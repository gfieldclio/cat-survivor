module Weapons
  module Laser
    DAMAGE = 10.freeze
    RADIUS = 200.freeze
    SPEED = 6.freeze
    DIRECTION_CHANGE_INTERVAL = 10 # Change direction every 10 frames

    def self.scout(args)
      init_laser(args) unless args.state.laser.direction
      move_laser_randomly_within_radius(args)

      # The laser's absolute position is its relative position plus the player's position.
      laser_x = args.state.player.x + args.state.laser.relative_x
      laser_y = args.state.player.y + args.state.laser.relative_y

      args.outputs.lines << [laser_x + 10, laser_y + 10, 1_000, 1_000, 255, 0, 0, 100]
    end

    def self.attack(args, enemy_x, enemy_y)
      init_laser(args) unless args.state.laser.direction
      move_laser_randomly_within_radius(args)

      laser_x = enemy_x
      laser_y = enemy_y

      args.outputs.lines << [laser_x + 10, laser_y + 10, 1_000, 1_000, 255, 0, 0, 100]
    end

    private

    def self.init_laser(args)
      args.state.laser.direction = rand * 360
      args.state.laser.relative_x = 0
      args.state.laser.relative_y = 0
      args.state.laser.frame_count = 0
    end

    def self.move_laser_randomly_within_radius(args)
      dx = ((rand * SPEED) + (rand * 2 - 1)) * Math.cos(args.state.laser.direction * Math::PI / 180)
      dy = ((rand * SPEED) + (rand * 2 - 1)) * Math.sin(args.state.laser.direction * Math::PI / 180)

      new_relative_x = args.state.laser.relative_x + dx
      new_relative_y = args.state.laser.relative_y + dy

      distance_from_center = Math.sqrt(new_relative_x**2 + new_relative_y**2)

      if distance_from_center > RADIUS
        args.state.laser.direction = (args.state.laser.direction + 180) % 360
      else
        args.state.laser.relative_x = new_relative_x
        args.state.laser.relative_y = new_relative_y
      end

      args.state.laser.frame_count += 1

      # Randomly change direction every DIRECTION_CHANGE_INTERVAL frames
      if args.state.laser.frame_count % DIRECTION_CHANGE_INTERVAL == 0
        args.state.laser.direction = rand * 360
      end
    end
  end
end
