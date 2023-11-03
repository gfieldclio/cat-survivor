module Scenes::Game
  module Stats
    def self.tick(args)
      args.outputs.labels << {
        x: 20,
        y: 700,
        text: "Level: " + args.state.player.level.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 155,
        g: 50,
        b: 50,
        a: 255,
        vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }
      
      args.outputs.labels << {
        x: 20,
        y: 650,
        text: "Health: " + args.state.player.health.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 155,
        g: 50,
        b: 50,
        a: 255,
        vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: 20,
        y: 600,
        text: "Enemies defeated: " + args.state.kill_count.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 155,
        g: 50,
        b: 50,
        a: 255,
        vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }
    end
  end
end