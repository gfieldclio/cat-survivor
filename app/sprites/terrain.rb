module Sprites
  module Terrain
    FILE_PATH = 'sprites/terrain/'.freeze
    TILE_SIZE = 16
    SPRITE_SIZE = 32

    FILE_MAP = {
      "desert" => "Set_A_Desert1.png",
      "hills1" => "Set_A_Hills1.png",
      "hills2" => "Set_A_Hills2.png",
      "hills3" => "Set_A_Hills3.png",
      "woods1" => "Set_A_Darkwoods1.png",
      "woods2" => "Set_A_Darkwoods2.png",
    }
    TILE_MAP = {
      "grass" => [1, 4],
      "grass_top" => [1, 3],
      "grass_right" => [2, 4],
      "grass_bottom" => [1, 5],
      "grass_left" => [0, 4],
      "grass_top_left" => [0, 3],
      "grass_top_right" => [2, 3],
      "grass_bottom_left" => [0, 5],
      "grass_bottom_right" => [2, 5],
      "ground1" => [1, 7],
      "ground1_top" => [1, 6],
      "ground1_right" => [2, 7],
      "ground1_bottom" => [1, 8],
      "ground1_left" => [0, 7],
      "ground1_top_left" => [0, 6],
      "ground1_top_right" => [2, 6],
      "ground1_bottom_left" => [0, 8],
      "ground1_bottom_right" => [2, 8],
      "ground2" => [1, 10],
      "ground2_top" => [1, 9],
      "ground2_right" => [2, 10],
      "ground2_bottom" => [1, 11],
      "ground2_left" => [0, 10],
      "ground2_top_left" => [0, 9],
      "ground2_top_right" => [2, 9],
      "ground2_bottom_left" => [0, 11],
      "ground2_bottom_right" => [2, 11],
      "rock1" => [6, 5],
      "rock2" => [7, 5],
      "water1" => [9, 1],
      "water1_top" => [9, 0],
      "water1_right" => [10, 1],
      "water1_bottom" => [9, 2],
      "water1_left" => [8, 1],
      "water1_top_left" => [8, 0],
      "water1_top_right" => [10, 0],
      "water1_bottom_left" => [8, 2],
      "water1_bottom_right" => [10, 2],
      "water1_rock1" => [13, 0],
      "water1_rock2" => [13, 1],
      "water2" => [9, 4],
      "water2_top" => [9, 3],
      "water2_right" => [10, 4],
      "water2_bottom" => [9, 5],
      "water2_left" => [8, 4],
      "water2_top_left" => [8, 3],
      "water2_top_right" => [10, 3],
      "water2_bottom_left" => [8, 5],
      "water2_bottom_right" => [10, 5],
      "water2_rock1" => [14, 0],
      "water2_rock2" => [14, 1],
      "water3" => [9, 7],
      "water3_top" => [9, 6],
      "water3_right" => [10, 7],
      "water3_bottom" => [9, 8],
      "water3_left" => [8, 7],
      "water3_top_left" => [8, 6],
      "water3_top_right" => [10, 6],
      "water3_bottom_left" => [8, 8],
      "water3_bottom_right" => [10, 8],
      "water3_rock1" => [15, 0],
      "water3_rock2" => [15, 1],
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
