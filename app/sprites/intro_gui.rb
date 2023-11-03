module Sprites
  module IntroGui
    FILE_PATH = 'sprites/gui/'.freeze

    # [source_w, source_h]
    TILE_MAP = {
      "start" => [64, 32],
      "credits" => [80, 32],
      "right" => [32, 32],
      "left" => [32, 32]
    }

    def self.tile(x:, y:, w:, h:, key:)
      path = "#{FILE_PATH}#{key}.png"
      source_w, source_h = sprite_position(key)
      sprite_index =
        0.frame_index count: 3, # how many sprites?
                      hold_for: 10, # how long to hold each sprite?
                      repeat: true # should it repeat?

      sprite_index ||= 0

      {
        x: x,
        y: y,
        w: w,
        h: h,
        source_x: source_w * sprite_index,
        source_y: 0,
        source_w: source_w,
        source_h: source_h,
        path: path,
      }
    end

    def self.sprite_position(key)
      TILE_MAP[key]
    end
  end
end