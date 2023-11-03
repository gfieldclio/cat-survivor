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

    def self.handle_weapon_switch(args)
      if args.inputs.keyboard.key_up.e
        return if args.state.player.unlocked_weapons.count == 1

        index = args.state.player.unlocked_weapons.find_index(args.state.player.weapon)

        index += 1
        index = 0 unless index.between?(0, args.state.player.unlocked_weapons.length - 1)

        args.state.player.weapon = args.state.player.unlocked_weapons[index]
        args.state.player.selected_weapon = index
        args.outputs.sounds << "audio/effects/change.wav"
      elsif args.inputs.keyboard.key_up.q
        return if args.state.player.unlocked_weapons.count == 1

        index = args.state.player.unlocked_weapons.find_index(args.state.player.weapon)

        index -= 1
        index = 0 if index < 0

        args.state.player.weapon = args.state.player.unlocked_weapons[index]
        args.state.player.selected_weapon = index
        args.outputs.sounds << "audio/effects/change.wav"
      end
    end

    def self.render_instructions(args)
      args.outputs.labels << {
        x: args.grid.center_x + 1,
        y: 30,
        text: "Use Q and E to toggle weapons",
        # size specification can be either size_enum or size_px
        size_enum: 5,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 1,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: args.grid.center_x - 1,
        y: 30,
        text: "Use Q and E to toggle weapons",
        # size specification can be either size_enum or size_px
        size_enum: 5,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 1,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: args.grid.center_x,
        y: 30 + 1,
        text: "Use Q and E to toggle weapons",
        # size specification can be either size_enum or size_px
        size_enum: 5,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 1,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: args.grid.center_x,
        y: 30 - 1,
        text: "Use Q and E to toggle weapons",
        # size specification can be either size_enum or size_px
        size_enum: 5,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 1,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: args.grid.center_x,
        y: 30,
        text: "Use Q and E to toggle weapons",
        # size specification can be either size_enum or size_px
        size_enum: 5,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 1,
        r: 255,
        g: 255,
        b: 255,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }
    end
  end
end
