module Scenes
  module Intro
    def self.tick(args)
      render_background(args)
      args.state.cat ||= 1

      cycle_cats(args)
      if args.keyboard.key_down.enter || args.controller_one.x
        select_cat(args)
      end

      render_shadow_text(args, x: args.grid.center_x, y: 600, text: "Cat Survivor", size_enum: 75, offset: 2)
      render_shadow_text(args,
                         x: args.grid.center_x,
                         y: 400,
                         text: "Select a cat with the Left or Right keys, then press Enter to start the game!",
                         size_enum: 5,
                         offset: 1)

      render_cat(args)
      render_start_button(args)
      render_credits_button(args)
      render_arrows(args)
    end

    def self.right_input(args)
      args.keyboard.key_down.right || args.controller_one.right || button_clicked?(args, args.state.right_button)
    end

    def self.left_input(args)
      args.keyboard.key_down.left || args.controller_one.left || button_clicked?(args, args.state.left_button)
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
      Scenes::Game.reset(args)
      args.state.player.cat_type = "cat_#{args.state.cat}"
      args.state.player.health = 500
      args.state.scene = :game
      args.audio[:bg_music] = { input: "audio/music/abstraction-box_jump.ogg", looping: true, gain: 0.5 }
    end

    def self.render_cat(args)
      start_animation_on_tick = 180

      sprite_index =
        start_animation_on_tick.frame_index count: 3, # how many sprites?
                                            hold_for: 15, # how long to hold each sprite?
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

    def self.render_start_button(args)
      args.state.start_button = create_button(args, x: args.grid.center_x - 75, y: 100, w: 150, h: 75, key: "start")

      if button_clicked? args, args.state.start_button
        select_cat(args)
      end
    end

    def self.render_arrows(args)
      left_x = args.grid.center_x - 175
      right_x = args.grid.center_x + 100
      y = 200
      w = 75
      h = 75

      args.state.right_button = create_button(args, x: right_x, y: y, w: w, h: h, key: "right")
      args.state.left_button = create_button(args, x: left_x, y: y, w: w, h: h, key: "left")
    end

    def self.render_credits_button(args)
      args.state.credits_button = create_button(args, x: args.grid.center_x - 75, y: 10, w: 150, h: 75, key: "credits")

      if button_clicked? args, args.state.credits_button
        args.state.scene = :credits
        return
      end
    end

    def self.button_clicked? args, button
      return false unless args.inputs.mouse.click
      return args.inputs.mouse.point.inside_rect? button[:rect]
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

    def self.render_shadow_text(args, x:, y:, text:, size_enum:, offset:)
      args.outputs.labels << { # shadow 1
                               x: x + offset,
                               y: y,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_enum: size_enum,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # shadow 2
                               x: x - offset,
                               y: y,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_enum: size_enum,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # shadow 3
                               x: x,
                               y: y + offset,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_enum: size_enum,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # shadow 4
                               x: x,
                               y: y - offset,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_enum: size_enum,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 0,
                               g: 0,
                               b: 0,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: "fonts/Abaddon_Bold.ttf"
      }

      args.outputs.labels << { # main text
                               x: x,
                               y: y,
                               text: text,
                               # size specification can be either size_enum or size_px
                               size_enum: size_enum,
                               # 0 represents "left aligned". 1 represents "center aligned". 2 represents "right aligned".
                               alignment_enum: 1,
                               r: 250,
                               g: 50,
                               b: 50,
                               a: 255,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: "fonts/Abaddon_Bold.ttf"
      }
    end
  end
end
