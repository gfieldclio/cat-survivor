module Sprites
  module Slime
    FILE_PATH = 'sprites/slime/'.freeze
    TILE_SIZE = 47

    FILE_MAP = {
      "walking" => "D_Walk.png",
      "dying" => "D_Death.png",
    }
    TILE_MAP = {
      "walking" => [1, 0],
      "dying" => [1, 0],
    }

    def self.tile(slime:, x:, y:, type:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = tile_asset_position(type)

      frames_in_sprite_sheet = 6
      ticks_per_frame = 8

      if type == "dying"
        tile_index = slime.started_dying_at.frame_index(frames_in_sprite_sheet,
                                    ticks_per_frame,
                                    false)
        return if tile_index.nil?
      else
        tile_index = slime.started_running_at.frame_index(frames_in_sprite_sheet,
                                    ticks_per_frame,
                                    true)

      end

      {
        x: x,
        y: y,
        w: TILE_SIZE * 2,
        h: TILE_SIZE * 2,
        path: path,
        tile_x: tile_x + (tile_index * TILE_SIZE),
        tile_y: tile_y,
        tile_w: TILE_SIZE,
        tile_h: TILE_SIZE
      }
    end

    def self.tile_asset_position(key)
      TILE_MAP[key]
    end
  end
end
