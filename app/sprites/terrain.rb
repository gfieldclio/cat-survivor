module Sprites
  module Terrain
    FILE_PATH = 'sprites/terrain/'.freeze
    TILE_SIZE = 16
    SPRITE_SIZE = 32

    FILE_MAP = {
      "hills" => "Set_A_Hills1.png",
    }
    TILE_MAP = {
      "ground" => [1, 4],
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
