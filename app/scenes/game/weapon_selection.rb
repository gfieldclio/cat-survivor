module Scenes::Game
  module WeaponSelection
    def self.render_icons(args)
      args.outputs.sprites << {
        x: SCREEN_WIDTH/2,
        y: 100,
        w: 96,
        h: 32,
        path: get_weapon_image(args),
        source_x: 0,
        source_y: 0,
        source_w: 96,
        source_h: 32,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
    end

    def self.render_selection_arrow(args)
      start_animation_on_tick = 0

      sprite_index = 
        start_animation_on_tick.frame_index count: 12,    # how many sprites?
                                            hold_for: 2,  # how long to hold each sprite?
                                            repeat: true  # should it repeat?

      sprite_index ||= 0
      
      args.outputs.sprites << {
        x: selection_level_x[args.state.player.selected_weapon],
        y: 140,
        w: 32,
        h: 32,
        path:  'sprites/weapons/selection_arrow.png',
        source_x: 32 * sprite_index,
        source_y: 0,
        source_w: 32,
        source_h: 32,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
    end

    def self.get_weapon_image(args)
      if args.state.player.level < 3
        'sprites/weapons/selection_1.png'
      elsif args.state.player.level < 5
        'sprites/weapons/selection_2.png'
      elsif args.state.player.level >= 5
        'sprites/weapons/selection_3.png'
      end
    end

    def self.selection_level_x
      {
        0 => SCREEN_WIDTH/2 - 32,
        1 => SCREEN_WIDTH/2,
        2 => SCREEN_WIDTH/2 + 32,
      }
    end
  end
end
