module Sprites
  module Heart
    FILE_PATH = 'sprites/hearts/'.freeze
    TILE_WIDTH = 18
    TILE_HEIGHT = 16
    SPRITE_WIDTH = 36
    SPRITE_HEIGHT = 32

    FILE_MAP = {
      "background" => "background.png",
      "border" => "border.png",
      "foreground" => "heart.png",
    }

    HEART_SPRITE_MAP = {
      'heart' => [0, 0],
    }

    # change these with key presses
    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = sprite_position(key)

      {
        x: x,
        y: y,
        w: SPRITE_WIDTH,
        h: SPRITE_HEIGHT,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: TILE_WIDTH,
        tile_h: TILE_HEIGHT,
        path: path,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
    end

    def self.sprite_position(key)
      HEART_SPRITE_MAP[key]
    end
  end
end
