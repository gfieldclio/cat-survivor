module Sprites
  module Orc
    FILE_PATH = 'sprites/orc/'.freeze
    TILE_SIZE = 45

    FILE_MAP = {
      "down_walking" => "D_Walk.png",
      "down_dying" => "D_Death.png",
      "side_walking" => "S_Walk.png",
      "side_dying" => "S_Death.png",
      "up_walking" => "U_Walk.png",
      "up_dying" => "U_Death.png"
    }

    SPRITE_MAP = {
      'down_walking_0' => [9, 12],
      'down_walking_1' => [58, 12],
      'down_walking_2' => [105, 12],
      'down_walking_3' => [153, 12],
      'down_walking_4' => [203, 12],
      'down_walking_5' => [249, 12],
      'side_walking_0' => [9, 12],
      'side_walking_1' => [58, 12],
      'side_walking_2' => [105, 12],
      'side_walking_3' => [153, 12],
      'side_walking_4' => [203, 12],
      'side_walking_5' => [249, 12],
      'up_walking_0' => [9, 12],
      'up_walking_1' => [58, 12],
      'up_walking_2' => [105, 12],
      'up_walking_3' => [153, 12],
      'up_walking_4' => [203, 12],
      'up_walking_5' => [249, 12],
      'down_dying_0' => [9, 12],
      'down_dying_1' => [58, 12],
      'down_dying_2' => [105, 12],
      'down_dying_3' => [153, 12],
      'down_dying_4' => [203, 12],
      'down_dying_5' => [249, 12],
      'side_dying_0' => [9, 12],
      'side_dying_1' => [58, 12],
      'side_dying_2' => [105, 12],
      'side_dying_3' => [153, 12],
      'side_dying_4' => [203, 12],
      'side_dying_5' => [249, 12],
      'up_dying_0' => [9, 12],
      'up_dying_1' => [58, 12],
      'up_dying_2' => [105, 12],
      'up_dying_3' => [153, 12],
      'up_dying_4' => [203, 12],
      'up_dying_5' => [249, 12],
    }

    def self.tile(orc:, x:, y:, type:, flip_horizontally:)
      path = FILE_PATH + FILE_MAP[type]

      frames_in_sprite_sheet = 6
      ticks_per_frame = 8

      if type.include?("dying")
        tile_index = orc.started_dying_at.frame_index(frames_in_sprite_sheet,
                                    ticks_per_frame,
                                    false)
        return if tile_index.nil?
      else
        tile_index = orc.started_running_at.frame_index(frames_in_sprite_sheet,
                                    ticks_per_frame,
                                    true)

      end

      key = "#{type}_#{tile_index}"
      tile_x, tile_y = sprite_position(key)

      {
        x: x,
        y: y,
        w: TILE_SIZE * 1.5,
        h: TILE_SIZE * 1.5,
        path: path,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: TILE_SIZE,
        tile_h: TILE_SIZE,
        anchor_x: 0.5,
        anchor_y: 0.5,
        flip_horizontally: flip_horizontally
      }
    end

    def self.sprite_position(key)
      SPRITE_MAP[key]
    end
  end
end
