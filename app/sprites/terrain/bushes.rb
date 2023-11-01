module Sprites
  module Terrain
    FILE_PATH = 'sprites/terrain/Set_B_Exteriors'.freeze
    TILE_SIZE = 16
    SPRITE_SIZE = 32

    TILE_MAP = {
      "bush1" => [1, 0],
      "bush1_flowers" => [2, 0],
      "bush2" => [3, 0],
      "bush2_flowers" => [4, 0],
      "bush3" => [5, 0],
      "bush3_flowers" => [6, 0],
      "bush4" => [0, 1],
      "bush4_flowers" => [1, 1],
      "bush5" => [2, 1],
      "bush5_flowers" => [3, 1],
      "bush6" => [4, 1],
      "bush6_flowers" => [5, 1],
      "snow_bush" => [7, 0],
    }

    def self.tile(x:, y:, type:, key:)
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
        path: FILE_PATH
      }
    end

    def self.tile_position(key)
      TILE_MAP[key]
    end
  end
end
