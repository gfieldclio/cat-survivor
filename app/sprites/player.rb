module Sprites
  module Player
    FILE_PATH = 'sprites/cats/'.freeze
    TILE_WIDTH = 30
    TILE_HEIGHT = 32
    SPRITE_WIDTH = 60
    SPRITE_HEIGHT = 64

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

    PLAYER_SPRITE_MAP = {
      # 'down_walk_1' => [5, 6],
      # 'down_walk_2' => [69, 6],
      # 'down_still' => [37, 6],
      # 'left_walk_1' => [5, 38],
      # 'left_walk_2' => [69, 38],
      # 'left_still' => [37, 38],
      # 'right_walk_1' => [5, 70],
      # 'right_walk_2' => [69, 70],
      # 'right_still' => [37, 70],
      # 'up_walk_1' => [5, 102],
      # 'up_walk_2' => [69, 102],
      # 'up_still' => [37, 102]
      'down_walk_1' => [1, 0],
      'down_walk_2' => [65, 0],
      'down_still' => [33, 0],
      'left_walk_1' => [1, 32],
      'left_walk_2' => [65, 32],
      'left_still' => [33, 32],
      'right_walk_1' => [1, 64],
      'right_walk_2' => [65, 64],
      'right_still' => [33, 64],
      'up_walk_1' => [1, 96],
      'up_walk_2' => [65, 96],
      'up_still' => [33, 96]
    }

    # change these with key presses
    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = sprite_position(key)

      {
        x: x,
        y: y,
        w: SPRITE_WIDTH,
        h: SPRITE_HEIGHT,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: TILE_WIDTH,
        tile_h: TILE_HEIGHT,
        path: path,
        anchor_x: 0.5,
        anchor_y: 0.5
      }
    end

    def self.sprite_position(key)
      PLAYER_SPRITE_MAP[key]
    end
  end
end
