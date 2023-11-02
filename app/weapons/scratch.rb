module Weapons
  class Scratch
    DAMAGE = 10.freeze
    FRAMES = 12.freeze

    def initialize(enemy_x, enemy_y)
      @enemy_x = enemy_x
      @enemy_y = enemy_y
      @sprite_index = 0
    end

    def attack(args)
      render(args)
      damage
    end

    def closest_enemy
      # Code to get the closest enemy to the player
      # Set a radius from the player and find the neighbouring enemies within the radious.
      # From the list of enemies, get the closest one

      # returns hash {:x, :y}
    end

    def in_progress?
      return true if @sprite_index < FRAMES

      false
    end

    private

    def render(args)
      start_animation_on_tick = 0

      @sprite_index = 
        start_animation_on_tick.frame_index count: FRAMES,    # how many sprites?
                                            hold_for: 2,  # how long to hold each sprite?
                                            repeat: true  # should it repeat?

      @sprite_index ||= 0  
      
      args.outputs.sprites << {
        x: @enemy_x,
        y: @enemy_y,
        w: 32,
        h: 32,
        path:  'sprites/weapons/scratch.png',
        source_x: 32 * @sprite_index,
        source_y: 0,
        source_w: 32,
        source_h: 32
      }
    end

    def damage
      DAMAGE
    end
  end
end