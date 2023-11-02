module Weapons
  module Feather
    DAMAGE = 10.freeze
    MAX_ROTATION_ANGLE = 20.freeze  # The max rotation angle from the base angle
    ROTATION_SPEED = 1.freeze       # The speed of rotation per frame
    RADIUS = 200.freeze
    SPEED = 6.freeze
    DIRECTION_CHANGE_INTERVAL = 10 # Change direction every 10 frames

    def self.scout(args)
      init_feather(args) unless args.state.feather.angle || args.state.feather.rotation_direction
      move_feather_randomly_within_radius(args)

      pos_x = args.state.player.x + args.state.feather.relative_x
      pos_y = args.state.player.y + args.state.feather.relative_y

      render(args, pos_x, pos_y)
    end

    def self.attack(args, enemy_x, enemy_y)
      init_feather(args) unless args.state.feather.angle || args.state.feather.rotation_direction
      move_feather_randomly_within_radius(args)

      render(args, enemy_x, enemy_y)
    end

    def self.render(args, pos_x, pos_y)
      init_feather(args) unless args.state.feather.angle && args.state.feather.rotation_direction

      args.state.feather.angle += args.state.feather.rotation_direction * ROTATION_SPEED

      if args.state.feather.angle >= 180 + MAX_ROTATION_ANGLE || args.state.feather.angle <= 180 - MAX_ROTATION_ANGLE
        args.state.feather.rotation_direction = -args.state.feather.rotation_direction
      end

      args.outputs.sprites << {
        x: pos_x - 50,
        y: pos_y - 50,
        w: 256,
        h: 256,
        path: 'sprites/weapons/feather.png',
        source_x: 0,
        source_y: 0,
        source_w: 256,
        source_h: 256,
        angle: args.state.feather.angle,
        anchor_x: 0,
        anchor_y: 0,
      }
    end

    def self.init_feather(args)
      args.state.feather ||= {}
      args.state.feather.angle = 180
      args.state.feather.rotation_direction = ROTATION_SPEED
      args.state.feather.direction = rand * 360
      args.state.feather.relative_x = 0
      args.state.feather.relative_y = 0
      args.state.feather.frame_count = 0
    end

    def self.move_feather_randomly_within_radius(args)
      dx = ((rand * SPEED) + (rand * 2 - 1)) * Math.cos(args.state.feather.direction * Math::PI / 180)
      dy = ((rand * SPEED) + (rand * 2 - 1)) * Math.sin(args.state.feather.direction * Math::PI / 180)

      new_relative_x = args.state.feather.relative_x + dx
      new_relative_y = args.state.feather.relative_y + dy

      distance_from_center = Math.sqrt(new_relative_x**2 + new_relative_y**2)

      if distance_from_center > RADIUS
        args.state.feather.direction = (args.state.feather.direction + 180) % 360
      else
        args.state.feather.relative_x = new_relative_x
        args.state.feather.relative_y = new_relative_y
      end

      args.state.feather.frame_count += 1

      if args.state.feather.frame_count % DIRECTION_CHANGE_INTERVAL == 0
        args.state.feather.direction = rand * 360
      end
    end
  end
end
