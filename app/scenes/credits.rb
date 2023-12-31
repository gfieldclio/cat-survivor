module Scenes
  module Credits
    def self.tick(args)
      if args.keyboard.key_down.enter
        args.state.scene = :intro
        return
      end

      render_background(args)
      render_credits(args)
      render_main_menu_button(args)
    end

    def self.render_background(args)
      args.outputs.sprites << { x: 0, y: 0, w: 1280, h: 720, path: 'sprites/background/background_plains-Sheet1.png' }
      scroll_point_at = args.state.tick_count
      scroll_point_at ||= 0

      args.outputs.sprites << scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet2.png', 0.25)
      args.outputs.sprites << scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet3.png', 0.50)
      args.outputs.sprites << scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet4.png', 1.00)
      args.outputs.sprites << scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet5.png', 1.50)
    end

    def self.scrolling_background at, path, rate, y = 0
      [
        { x: 0 - at.*(rate) % 1440, y: y, w: 1440, h: 720, path: path },
        { x: 1440 - at.*(rate) % 1440, y: y, w: 1440, h: 720, path: path }
      ]
    end

    def self.render_credits(args)
      line_y = 700

      render_shadow_text(args, x: args.grid.center_x, y: line_y, text: "Built By", size_px: 54, offset: 2, font: "bold")

      line_y -= 25
      [
        'Yasmeen Akbari',
        'Nimi Dharithreesan',
        'Greg Field',
        'Sam Markham',
        'Mishal Zaman'
      ].each do |name|
        line_y -= 25
        render_shadow_text(args, x: args.grid.center_x, y: line_y, text: name, size_px: 32, offset: 0, font: "light")
      end

      line_y -= 50

      render_shadow_text(args, x: args.grid.center_x, y: line_y, text: "Inspired By", size_px: 54, offset: 2, font: "bold")

      line_y -= 25
      [
        'Vampire Survival',
        "Our Pets <3"
      ].each do |name|
        line_y -= 25
        render_shadow_text(args, x: args.grid.center_x, y: line_y, text: name, size_px: 32, offset: 0, font: "light")
      end

      line_y -= 50

      render_shadow_text(args, x: args.grid.center_x, y: line_y, text: "Assets By", size_px: 54, offset: 2, font: "bold")

      line_y -= 25
      [
        "BDragon1727: https://bdragon1727.itch.io/basic-pixel-gui-and-buttons-pack-2",
        "Free Game Assets: https://free-game-assets.itch.io/free-field-enemies-pixel-art-for-tower-defense",
        "kiddolink: https://kiddolink.itch.io/parallax-background-plains-pixel-art",
        "Mega Tiles: https://megatiles.itch.io/tiny-tales-overworld-2d-tileset-asset-pack",
        "Nathan Scott: https://caffinate.itch.io/abaddon",
        "Pipoya: https://pipoya.itch.io/pipoya-free-rpg-character-sprites-nekonin",
        "Tallbeard Studios: https://tallbeard.itch.io/three-red-hearts-prepare-to-dev",
        "VampireGirl: https://fliflifly.itch.io/hearts-and-health-bar"
      ].each do |name|
        line_y -= 25
        render_shadow_text(args, x: args.grid.center_x, y: line_y, text: name, size_px: 32, offset: 0, font: "light")
      end
    end

    def self.create_button(args, x:, y:, w:, h:, key:)

      button = {
        rect: { x: x, y: y, w: w, h: h }
      }

      button_sprite = args.outputs.sprites << Sprites::IntroGui.tile(x: x, y: y, w: w, h: h, key: key)
      button[:primitives] = [
        button_sprite.sprite,

      ]

      args.outputs.primitives << button[:primitives]
      button
    end

    def self.button_clicked? args, button
      return false unless args.inputs.mouse.click
      return args.inputs.mouse.point.inside_rect? button[:rect]
    end

    def self.render_main_menu_button(args)
      args.state.main_menu_button = create_button(args, x: args.grid.center_x - 75, y: 10, w: 150, h: 75, key: "main_menu")

      if button_clicked? args, args.state.main_menu_button
        args.state.scene = :intro
        return
      end
    end

    def self.render_shadow_text(args, x:, y:, text:, size_px:, offset:, font:)
      font_path = font == "bold" ? "fonts/Abaddon_Bold.ttf" : "fonts/Abaddon_Light.ttf"
      args.outputs.labels << { # shadow 1
                               x: x + offset,
                               y: y,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_px: size_px,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: font_path
      }

      args.outputs.labels << { # shadow 2
                               x: x - offset,
                               y: y,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_px: size_px,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: font_path
      }

      args.outputs.labels << { # shadow 3
                               x: x,
                               y: y + offset,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_px: size_px,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: font_path
      }

      args.outputs.labels << { # shadow 4
                               x: x,
                               y: y - offset,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_px: size_px,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: font_path
      }

      args.outputs.labels << { # main text
                               x: x,
                               y: y,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_px: size_px,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 250,
                               g: 50,
                               b: 50,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: font_path
      }
    end
  end
end