module Sprites
  module Player
    FILE_PATH = 'sprites/cats/'.freeze
    TILE_WIDTH = 30
    TILE_HEIGHT = 32
    SPRITE_WIDTH = 60
    SPRITE_HEIGHT = 62

    FILE_MAP = {
      "cat_1" => "pipo-nekonin001.png",
      "cat_2" => "pipo-nekonin002.png",
      "cat_3" => "pipo-nekonin003.png",
      "cat_4" => "pipo-nekonin004.png",
      "cat_5" => "pipo-nekonin005.png",
      "cat_6" => "pipo-nekonin006.png",
      "cat_7" => "pipo-nekonin007.png",
      "cat_8" => "pipo-nekonin008.png",
      "cat_9" => "pipo-nekonin009.png",
      "cat_10" => "pipo-nekonin010.png",
      "cat_11" => "pipo-nekonin011.png",
      "cat_12" => "pipo-nekonin012.png",
      "cat_13" => "pipo-nekonin013.png",
      "cat_14" => "pipo-nekonin014.png",
      "cat_15" => "pipo-nekonin015.png",
      "cat_16" => "pipo-nekonin016.png",
      "cat_17" => "pipo-nekonin017.png",
      "cat_18" => "pipo-nekonin018.png",
      "cat_19" => "pipo-nekonin019.png",
      "cat_20" => "pipo-nekonin020.png",
      "cat_21" => "pipo-nekonin021.png",
      "cat_22" => "pipo-nekonin022.png",
      "cat_23" => "pipo-nekonin023.png",
      "cat_24" => "pipo-nekonin024.png",
      "cat_25" => "pipo-nekonin025.png",
      "cat_26" => "pipo-nekonin026.png",
      "cat_27" => "pipo-nekonin027.png",
      "cat_28" => "pipo-nekonin028.png",
      "cat_29" => "pipo-nekonin029.png",
      "cat_30" => "pipo-nekonin030.png",
      "cat_31" => "pipo-nekonin031.png",
      "cat_32" => "pipo-nekonin032.png",
    }
    # Point to bottom middle since it's a consistent location for all sprites
    PLAYER_SPRITE_MAP = {
      'down_walk_1' => [16, 32],
      'down_walk_2' => [80, 32],
      'down_still' => [48, 31],
      'left_walk_1' => [16, 64],
      'left_walk_2' => [80, 64],
      'left_still' => [48, 63],
      'right_walk_1' => [16, 96],
      'right_walk_2' => [80, 96],
      'right_still' => [48, 95],
      'up_walk_1' => [16, 128],
      'up_walk_2' => [80, 128],
      'up_still' => [48, 127]
    }
    TILE_SIZES = {
      "cat_1" => [20, 25],
      "cat_2" => [20, 25],
      "cat_3" => [20, 25],
      "cat_4" => [20, 25],
      "cat_5" => [20, 25],
      "cat_6" => [20, 25],
      "cat_7" => [20, 25],
      "cat_8" => [20, 25],
      "cat_9" => [20, 25],
      "cat_10" => [23, 28],
      "cat_11" => [20, 25],
      "cat_12" => [20, 25],
      "cat_13" => [24, 30],
      "cat_14" => [21, 25],
      "cat_15" => [30, 30],
      "cat_16" => [17, 24],
      "cat_17" => [17, 24],
      "cat_18" => [17, 24],
      "cat_19" => [29, 31],
      "cat_20" => [29, 24],
      "cat_21" => [21, 29],
      "cat_22" => [21, 27],
      "cat_23" => [21, 27],
      "cat_24" => [20, 25],
      "cat_25" => [20, 25],
      "cat_26" => [31, 31],
      "cat_27" => [31, 27],
      "cat_28" => [21, 25],
      "cat_29" => [19, 28],
      "cat_30" => [31, 31],
      "cat_31" => [21, 30],
      "cat_32" => [23, 28],
    }

    # change these with key presses
    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = sprite_position(type, key)
      tile_w, tile_h = TILE_SIZES[type]

      {
        x: x,
        y: y,
        w: tile_w * 2,
        h: tile_h * 2,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: tile_w,
        tile_h: tile_h,
        path: path,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
    end

    def self.sprite_position(type, key)
      x, y = PLAYER_SPRITE_MAP[key]
      x -= TILE_SIZES[type][0] / 2
      y -= TILE_SIZES[type][1]
      [x, y]
    end
  end
end
