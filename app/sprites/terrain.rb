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
    OBJECT_TILE_MAP = {
      "grass_rock1" => [6, 5],
      "grass_rock2" => [7, 5],
      "water1_rock1" => [13, 0],
      "water1_rock2" => [13, 1],
      "water2_rock1" => [14, 0],
      "water2_rock2" => [14, 1],
      "water3_rock1" => [15, 0],
      "water3_rock2" => [15, 1],
    }
    TILE_MAP = {
      "grass" => [1, 4],
      "ground1" => [1, 7],
      "ground2" => [1, 10],
      "water1" => [9, 1],
      "water2" => [9, 4],
      "water3" => [9, 7],
      "cliff1" => [1, 1],
      "cliff2" => [4, 1],
    }

    def self.tile(x:, y:, type:, key:, side: nil)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = tile_position(key, side)

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

    def self.object(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = object_tile_position(key)

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

    def self.tile_position(key, side)
      tile_x, tile_y = TILE_MAP[key]

      case side
      when "top"
        tile_y -= 1
      when "bottom"
        tile_y += 1
      when "left"
        tile_x -= 1
      when "right"
        tile_x += 1
      when "top_left"
        tile_x -= 1
        tile_y -= 1
      when "top_right"
        tile_x += 1
        tile_y -= 1
      when "bottom_left"
        tile_x -= 1
        tile_y += 1
      when "bottom_right"
        tile_x += 1
        tile_y += 1
      when "inner_top_left"
        tile_x += 2
        tile_y -= 1
      when "inner_top_right"
        tile_x += 3
        tile_y -= 1
      when "inner_bottom_left"
        tile_x += 2
      when "inner_bottom_right"
        tile_x += 3
      end

      [tile_x, tile_y]
    end

    def self.object_tile_position(key)
      OBJECT_TILE_MAP[key]
    end
  end
end
