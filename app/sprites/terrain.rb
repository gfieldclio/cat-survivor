module Sprites
  module Terrain
    FILE_PATH = 'sprites/terrain/'.freeze
    TILE_SIZE = 16

    FILE_MAP = {
      "hills" => "Set_A_Hills1.png",
    }
    SPRITE_MAP = {
      "ground" => [1, 4],
    }

    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = sprite_position(key)

      {
        x: x,
        y: y,
        w: TILE_SIZE * 2,
        h: TILE_SIZE * 2,
        tile_x: tile_x * TILE_SIZE,
        tile_y: tile_y * TILE_SIZE,
        tile_w: TILE_SIZE,
        tile_h: TILE_SIZE,
        path: path
      }
    end

    def self.sprite_position(key)
      SPRITE_MAP[key]
    end
  end
end
