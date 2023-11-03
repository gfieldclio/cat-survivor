module Weapons
  class Scratch
    DAMAGE = 10.freeze
    FRAMES = 12.freeze

    # def initialize(enemy_x, enemy_y)
    #   @enemy_x = enemy_x
    #   @enemy_y = enemy_y
    #   @sprite_index = 0
    # end

    def self.attack(args, enemy_x, enemy_y)
      render(args, enemy_x, enemy_y)
      damage
    end

    def self.radius
      150
    end

    def self.render(args, enemy_x, enemy_y)
      start_animation_on_tick = 0

      sprite_index =
        start_animation_on_tick.frame_index count: FRAMES,    # how many sprites?
                                            hold_for: 2,  # how long to hold each sprite?
                                            repeat: true  # should it repeat?

      sprite_index ||= 0
      # args.outputs.sounds << "audio/effects/claw.wav" if sprite_index == 0

      args.outputs.sprites << {
        x: enemy_x,
        y: enemy_y,
        w: 48,
        h: 48,
        path:  'sprites/weapons/scratch.png',
        source_x: 32 * sprite_index,
        source_y: 0,
        source_w: 32,
        source_h: 32,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
    end

    def self.damage
      DAMAGE
    end

    def self.play_attack_sound(args)
      args.state.weapon.playing_sound_start ||= args.state.tick_count
      args.state.weapon.playing_sound_start = nil if args.state.tick_count > args.state.weapon.playing_sound_start + 30
      args.outputs.sounds << "audio/effects/scratch.wav" if args.state.tick_count == args.state.weapon.playing_sound_start
    end
  end
end
