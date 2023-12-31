module Scenes
  module GameOver
    def self.tick(args)
      if args.keyboard.key_down.enter
        args.state.scene = :intro
        args.audio[:bg_music] = { input: "audio/music/abstraction-sanctuary.ogg", looping: true, gain: 0.1 }
        return
      end

      render_background(args)
      render_cat(args)
      render_shadow_text(
        args,
        x: args.grid.center_x,
        y: 500,
        text: "Game Over",
        size_enum: 50,
        offset: 1,
        main_text_r: 255,
        main_text_g: 50,
        main_text_b: 50,
        main_text_a: 255
      )
      render_shadow_text(
        args,
        x: args.grid.center_x,
        y: 385,
        text: "Highest Level: #{args.state.player.level}   EXP Earned: #{args.state.exp}",
        size_enum: 2,
        offset: 1,
        main_text_r: 255,
        main_text_g: 255,
        main_text_b: 255,
        main_text_a: 255
      )
      render_shadow_text(
        args,
        x: args.grid.center_x,
        y: 350,
        text: "Press Enter to return to the title screen.",
        size_enum: 2,
        offset: 1,
        main_text_r: 255,
        main_text_g: 255,
        main_text_b: 255,
        main_text_a: 255
      )
      render_main_menu_button(args)
    end

    def self.render_cat(args)
      start_animation_on_tick = 180

      sprite_index =
        start_animation_on_tick.frame_index count: 3, # how many sprites?
                                            hold_for: 60, # how long to hold each sprite?
                                            # sprite should hold for longer --slower = death animation
                                            repeat: true # should it repeat?

      sprite_index ||= 0

      args.outputs.primitives << {
        x: args.grid.center_x - 50,
        y: 200,
        w: 100,
        h: 100,
        tile_x: 32 * sprite_index,
        tile_y: 0,
        tile_w: 32,
        tile_h: 32,
        path: "sprites/cats/pipo-nekonin#{'%03d' % args.state.cat}.png" }.sprite
    end

    def self.render_background(args)
      scroll_point_at = args.state.tick_count
      scroll_point_at ||= 0

      primitives = [
        { x: 0, y: 0, w: 1280, h: 720, path: 'sprites/background/background_plains-Sheet1.png' }.sprite,
      ]

      primitives.push(*scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet2.png', 0.25))
      primitives.push(*scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet3.png', 0.50))
      primitives.push(*scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet4.png', 1.00))
      primitives.push(*scrolling_background(scroll_point_at, 'sprites/background/background_plains-Sheet5.png', 1.50))
      primitives.push({ x: 0, y: 0, w: 1280, h: 720, a: 128 }.solid!)

      args.outputs.primitives << primitives

    end

    def self.scrolling_background at, path, rate, y = 0
      [
        { x: 0 - at.*(rate) % 1440, y: y, w: 1440, h: 720, path: path }.sprite,
        { x: 1440 - at.*(rate) % 1440, y: y, w: 1440, h: 720, path: path }.sprite
      ]
    end

    def self.create_button(args, x:, y:, w:, h:, key:)

      button = {
        rect: { x: x, y: y, w: w, h: h }
      }

      button_sprite = Sprites::IntroGui.tile(x: x, y: y, w: w, h: h, key: key)
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
      args.state.main_menu_button = create_button(args, x: args.grid.center_x - 75, y: 100, w: 150, h: 75, key: "main_menu")

      if button_clicked? args, args.state.main_menu_button
        args.state.scene = :intro
        return
      end
    end

    def self.render_shadow_text(args, x:, y:, text:, size_enum:, offset:, main_text_r:, main_text_g:, main_text_b:, main_text_a:)
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
                              #  r: 255,
                              #  g: 50,
                              #  b: 50,
                              #  a: 255,
                               r: main_text_r,
                               g: main_text_g,
                               b: main_text_b,
                               a: main_text_a,
                               vertical_alignment_enum: 2, # 0 is bottom, 1 is middle, 2 is top
                               font: "fonts/Abaddon_Bold.ttf"
      }
    end
  end
end
