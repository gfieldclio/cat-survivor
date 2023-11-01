module Scenes::Game
  module Player
    FILE_PATH = 'sprites/cats/'.freeze
    TILE_WIDTH = 22
    TILE_HEIGHT = 25

    FILE_MAP = {
      "cat_1" => "pipo-nekonin006.png",
    }

    PLAYER_SPRITE_MAP = {
      'down_walk_1' => [5, 6],
      'down_walk_2' => [69, 6],
      'down_still' => [37, 6],
      'left_walk_1' => [5, 38],
      'left_walk_2' => [69, 38],
      'left_still' => [37, 38],
      'right_walk_1' => [5, 70],
      'right_walk_2' => [69, 70],
      'right_still' => [37, 70],
      'up_walk_1' => [5, 102],
      'up_walk_2' => [69, 102],
      'up_still' => [37, 102]
    }

    def self.tile(x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = sprite_position(key)

      {
        x: x,
        y: y,
        w: TILE_WIDTH,
        h: TILE_HEIGHT,
        tile_x: tile_x * TILE_WIDTH,
        tile_y: tile_y * TILE_HEIGHT,
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
