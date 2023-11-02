module Sprites
  module Terrain
    module Bushes
      FILE_PATH = 'sprites/terrain/Set_B_Exteriors.png'.freeze
      TILE_MAP = {
        "desert_bush" => [7, 2],
        "desert_bush_flowers" => [0, 3],
        "hills1_bush" => [1, 0],
        "hills1_bush_flowers" => [2, 0],
        "hills2_bush" => [5, 0],
        "hills2_bush_flowers" => [6, 0],
        "hills3_bush" => [3, 0],
        "hills3_bush_flowers" => [4, 0],
        "snow_bush" => [7, 0],
        "snow_bush_flowers" => [7, 0],
        "woods1_bush" => [2, 1],
        "woods1_bush_flowers" => [3, 1],
        "woods2_bush" => [4, 1],
        "woods2_bush_flowers" => [5, 1],
      }

      def self.tile(x:, y:, type:, key:)
        tile_x, tile_y = tile_position("#{type}_#{key}")

        {
          x: x,
          y: y,
          w: TERRAIN_SPRITE_SIZE,
          h: TERRAIN_SPRITE_SIZE,
          tile_x: tile_x * TERRAIN_TILE_SIZE,
          tile_y: tile_y * TERRAIN_TILE_SIZE,
          tile_w: TERRAIN_TILE_SIZE,
          tile_h: TERRAIN_TILE_SIZE,
          path: FILE_PATH
        }
      end

      def self.tile_position(key)
        TILE_MAP[key]
      end
    end
  end
end
