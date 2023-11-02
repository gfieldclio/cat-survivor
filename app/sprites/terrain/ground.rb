module Sprites
  module Terrain
    module Ground
      FILE_PATH = 'sprites/terrain/'.freeze
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
        key = "ground1" if type == "desert" && key == "grass"
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
    end
  end
end
