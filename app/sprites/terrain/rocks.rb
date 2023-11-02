module Sprites::Terrain
  module Rocks
    FILE_PATH = 'sprites/terrain/'.freeze
    TILE_SIZE = 16
    SPRITE_SIZE = 32

    FILE_MAP = {
      "desert" => "Set_A_Desert1.png",
      "hills1" => "Set_A_Hills1.png",
      "hills2" => "Set_A_Hills2.png",
      "hills3" => "Set_A_Hills3.png",
      "snow" => "Set_A_Snow1.png",
      "woods1" => "Set_A_Darkwoods1.png",
      "woods2" => "Set_A_Darkwoods2.png",
    }
    TILE_MAP = {
      "grass_rock1" => [6, 5],
      "grass_rock2" => [7, 5],
      "water1_rock1" => [13, 0],
      "water1_rock2" => [13, 1],
      "water2_rock1" => [14, 0],
      "water2_rock2" => [14, 1],
      "water3_rock1" => [15, 0],
      "water3_rock2" => [15, 1],
    }

    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = tile_position(key)

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

    def self.tile_position(key)
      TILE_MAP[key]
    end
  end
end
