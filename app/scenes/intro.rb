module Scenes
  module Intro
    def self.tick(args)
      args.state.rotation ||= 0
      args.state.cat ||= 1

      if args.inputs.right
        if args.state.cat === 32
          args.state.cat = 1
        else
          args.state.cat += 1
        end
      end

      if args.inputs.left
        if args.state.cat === 1
          args.state.cat = 32
        else
          args.state.cat -= 1
        end
      end

      args.outputs.labels << {
        x:                       500,
        y:                       550,
        text:                    "Choose your cat!",
        # size specification can be either size_enum or size_px
        size_enum:               2,
        size_px:                 22,
        alignment_enum:          0,
        r:                       155,
        g:                       50,
        b:                       50,
        a:                       255,
        vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
        anchor_x: 0.5,
        anchor_y: 0.5
      }
      start_animation_on_tick = 180

      sprite_index =
        start_animation_on_tick.frame_index count: 3,    # how many sprites?
                                            hold_for: 20,  # how long to hold each sprite?
                                            repeat: true  # should it repeat?

      sprite_index ||= 0

      args.outputs.sprites << { x: 500,
                                y: 200,
                                w: 100,
                                h: 100,
                                tile_x: 32 * sprite_index,
                                tile_y: 0,
                                tile_w: 32,
                                tile_h: 32,
                                path: "sprites/cats/pipo-nekonin#{'%03d' % args.state.cat}.png"}

    end
  end
end


