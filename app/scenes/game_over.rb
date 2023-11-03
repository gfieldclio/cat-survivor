module Scenes
  module GameOver
    def self.tick(args)
      if args.keyboard.key_down.enter
        args.state.scene = :intro
        return
      end

      args.outputs.labels << {
        x: args.grid.center_x,
        y: 400,
        text: "Game Over! Press Enter to return to the title screen.",
        size_enum: 2,
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

    def self.render_cat(args)
      start_animation_on_tick = 180

      sprite_index =
        start_animation_on_tick.frame_index count: 3, # how many sprites?
                                            hold_for: 30, # how long to hold each sprite?
                                            # sprite should hold for longer --slower = death animation
                                            repeat: true # should it repeat?

      sprite_index ||= 0

      args.outputs.sprites << {
        x: args.grid.center_x - 50,
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