module Weapons
  module Laser
    DAMAGE = 20.freeze
    RADIUS = 200.freeze
    SPEED = 6.freeze
    DIRECTION_CHANGE_INTERVAL = 10 # Change direction every 10 frames

    def self.scout(args)
      init_laser(args) unless args.state.laser.direction
      move_laser_randomly_within_radius(args)

      # The laser's absolute position is its relative position plus the player's position.
      laser_x = args.state.player.x + args.state.laser.relative_x
      laser_y = args.state.player.y + args.state.laser.relative_y

      render_laser(args, laser_x, laser_y)
    end

    def self.attack(args, enemy_x, enemy_y)
      init_laser(args) unless args.state.laser.direction
      move_laser_randomly_within_radius(args)

      laser_x = enemy_x
      laser_y = enemy_y

      render_laser(args, laser_x, laser_y)

      DAMAGE
    end

    def self.radius
      200
    end

    def self.init_laser(args)
      args.state.laser.direction = rand * 360
      args.state.laser.relative_x = 0
      args.state.laser.relative_y = 0
      args.state.laser.frame_count = 0
    end

    def self.render_laser(args, x, y)
      args.outputs.lines << [x + 10, y + 10, 1_000, 1_000, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_002, 1_002, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_004, 1_004, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_006, 1_006, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_008, 1_008, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_010, 1_012, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_012, 1_014, 255, 0, 0, 100]
      args.outputs.lines << [x + 10, y + 10, 1_014, 1_016, 255, 0, 0, 100]

      start_animation_on_tick = 0

      sprite_index =
        start_animation_on_tick.frame_index count: 10,
                                            hold_for: 6,
                                            repeat: true

      sprite_index ||= 0

      args.outputs.sprites << {
        x: x,
        y: y,
        w: 48,
        h: 48,
        path:  'sprites/weapons/scorch.png',
        source_x: 32 * sprite_index,
        source_y: 0,
        source_w: 32,
        source_h: 32,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
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

    def self.play_attack_sound(args)
      args.state.weapon.playing_sound_start ||= args.state.tick_count
      args.state.weapon.playing_sound_start = nil if args.state.tick_count > args.state.weapon.playing_sound_start + 30
      args.outputs.sounds << "audio/effects/laser.wav" if args.state.tick_count == args.state.weapon.playing_sound_start
    end
  end
end
