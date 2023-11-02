module Scenes
  module Intro
    def self.tick(args)
      args.state.cat ||= 1

      cycle_cats(args)
      select_cat(args)

      args.outputs.labels << {
        x: 600,
        y: 400,
        text: "Select a cat with the Left or Right keys, then press Enter to start the game!",
        # size specification can be either size_enum or size_px
        size_enum: 2,
        size_px: 22,
        alignment_enum: 1,
        r: 155,
        g: 50,
        b: 50,
        a: 255,
        vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
        anchor_x: 0.5,
        anchor_y: 0.5
      }

      render_cat(args)

    end

    def self.right_input(args)
      args.keyboard.key_down.right || args.controller_one.right
    end

    def self.left_input(args)
      args.keyboard.key_down.left || args.controller_one.left
    end

    def self.cycle_cats(args)
      if right_input(args)
        if args.state.cat === 32
          args.state.cat = 1
        else
          args.state.cat += 1
        end
      elsif left_input(args)
        if args.state.cat === 1
          args.state.cat = 32
        else
          args.state.cat -= 1
        end
      end
    end

    def self.select_cat(args)
      if args.keyboard.enter || args.controller_one.x
        args.state.player.cat_type = "cat_#{args.state.cat}"
        args.state.scene = :game
      end
    end

    def self.render_cat(args)
      start_animation_on_tick = 180

      sprite_index =
        start_animation_on_tick.frame_index count: 3, # how many sprites?
                                            hold_for: 15, # how long to hold each sprite?
                                            repeat: true # should it repeat?

      sprite_index ||= 0

      args.outputs.sprites << { x: 500,
                                y: 200,
                                w: 100,
                                h: 100,
                                tile_x: 32 * sprite_index,
                                tile_y: 0,
                                tile_w: 32,
                                tile_h: 32,
                                path: "sprites/cats/pipo-nekonin#{'%03d' % args.state.cat}.png" }
    end
  end
end


