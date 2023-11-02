module Sprites
  module Terrain
    module Trees
      FILE_PATH = 'sprites/terrain/Set_B_Exteriors.png'.freeze
      TILE_MAP = {
        "desert_tree1" => [0, 14],
        "desert_tree2" => [4, 14],
        "hills1_tree1" => [0, 4],
        "hills1_tree2" => [4, 4],
        "hills2_tree1" => [0, 8],
        "hills2_tree2" => [0, 10],
        "hills3_tree1" => [0, 6],
        "hills3_tree2" => [4, 6],
        "snow_tree1" => [8, 0],
        "snow_tree2" => [8, 2],
        "woods1_tree1" => [4, 10],
        "woods1_tree2" => [4, 8],
        "woods2_tree1" => [0, 12],
        "woods2_tree2" => [4, 12],
      }

      def self.tile(x:, y:, type:, key:, piece:)
        tile_x, tile_y = tile_position("#{type}_#{key}", piece)

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
          # noop
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
