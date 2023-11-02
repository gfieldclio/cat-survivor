module Sprites
  module Terrain
    module Trees
      FILE_PATH = 'sprites/terrain/Set_B_Exteriors'.freeze
      TILE_MAP = {
        "bare1" => [0, 12],
        "bare2" => [4, 12],
        "leafy1" => [0, 4],
        "leafy2" => [0, 6],
        "leafy3" => [0, 8],
        "leafy4" => [0, 10],
        "leafy5" => [4, 10],
        "pine1" => [4, 4],
        "pine2" => [4, 6],
        "pine3" => [4, 8],
        "snowy_bare1" => [8, 0],
        "snowy_bare2" => [12, 0],
        "snowy_pine1" => [8, 4],
        "palm" => [0, 14],
        "cactus" => [4, 14],
      }

      def self.tile(x:, y:, key:, piece:)
        tile_x, tile_y = tile_position(key, piece)

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

      def self.tile_position(key, piece)
        tile_x, tile_y = TILE_MAP[key]

        case piece
        when "top_left"
          # nothing
        when "top_right"
          tile_x += 1
        when "bottom_left"
          tile_y += 1
        when "bottom_right"
          tile_x += 1
          tile_y += 1
        when "forest_top_left"
          tile_x += 2
        when "forest_top_right"
          tile_x += 3
        when "forest_bottom_left"
          tile_x += 2
          tile_y += 1
        when "forest_bottom_right"
          tile_x += 3
          tile_y += 1
        end

        [tile_x, tile_y]
      end
    end
  end
end
