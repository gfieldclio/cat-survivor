module Scenes::Game
  module Stats
    def self.tick(args)
      # Level

      args.outputs.labels << { # shadow 1
        x: 750 + 1,
        y: 75,
        text: "Level: " + args.state.player.level.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # shadow 2
        x: 750 - 1,
        y: 75,
        text: "Level: " + args.state.player.level.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # shadow 3
        x: 750,
        y: 75 + 1,
        text: "Level: " + args.state.player.level.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # shadow 4
        x: 750,
        y: 75 - 1,
        text: "Level: " + args.state.player.level.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # main text
        x: 750,
        y: 75,
        text: "Level: " + args.state.player.level.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 255,
        g: 255,
        b: 255,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      # Kill count

      args.outputs.labels << {
        x: 900 + 1,
        y: 75,
        text: "EXP: " + args.state.exp.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: 900 - 1,
        y: 75,
        text: "EXP: " + args.state.exp.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: 900,
        y: 75 + 1,
        text: "EXP: " + args.state.exp.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: 900,
        y: 75 - 1,
        text: "EXP: " + args.state.exp.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 0,
        g: 0,
        b: 0,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << {
        x: 900,
        y: 75,
        text: "EXP: " + args.state.exp.to_s,
        # size specification can be either size_enum or size_px
        size_enum: 10,
        # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
        alignment_enum: 0,
        r: 255,
        g: 255,
        b: 255,
        a: 255,
        vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
        font: "fonts/Abaddon_Bold.ttf"
      }

      render_health(args)
    end

    def self.render_health(args)
      11.times do |i|
        args.outputs.sprites << Sprites::Heart.tile(x: 100 + (i * 40), y: 100, type: "background", key: "heart")
        args.outputs.sprites << Sprites::Heart.tile(x: 100 + (i * 40), y: 100, type: "border", key: "heart")
      end
      args.outputs.sprites << Sprites::Heart.tile(x: 100, y: 100, type: "foreground", key: "heart")

      (args.state.player.health / 50).to_i.times do |i|
        args.outputs.sprites << Sprites::Heart.tile(x: 140 + (i * 40), y: 100, type: "foreground", key: "heart")
      end
    end

  end
end