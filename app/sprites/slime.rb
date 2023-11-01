module Sprites
  module Slime
    FILE_PATH = 'sprites/slime/'.freeze
    TILE_SIZE = 18
    SPRITE_SIZE = 32

    FILE_MAP = {
      "slime_walking" => "S_Walk.png",
    }
    TILE_MAP = {
      "still" => [1, 1],
    }

    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = tile_asset_position(key)

      {
        x: x,
        y: y,
        w: SPRITE_SIZE,
        h: SPRITE_SIZE,
        tile_x: tile_x * TILE_SIZE,
        tile_y: tile_y * TILE_SIZE,
        tile_w: TILE_SIZE,
        tile_h: TILE_SIZE,
        path: path
      }
    end

    def self.tile_asset_position(key)
      TILE_MAP[key]
    end
  end
end
