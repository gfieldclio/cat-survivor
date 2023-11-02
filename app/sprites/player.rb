module Sprites
  module Player
    FILE_PATH = 'sprites/cats/'.freeze
    TILE_WIDTH = 30
    TILE_HEIGHT = 32

    FILE_MAP = {
      "cat_1" => "pipo-nekonin006.png",
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
        w: TILE_WIDTH * 3,
        h: TILE_HEIGHT * 3,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: TILE_WIDTH,
        tile_h: TILE_HEIGHT,
        path: path
      }
    end

    def self.sprite_position(key)
      PLAYER_SPRITE_MAP[key]
    end
  end
end
