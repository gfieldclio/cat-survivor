module Sprites
  module Slime
    FILE_PATH = 'sprites/slime/'.freeze
    TILE_SIZE = 47

    FILE_MAP = {
      "slime_walking" => "D_Walk.png",
      "slime_death" => "D_Death.png",
    }
    TILE_MAP = {
      "walking" => [1, 0],
    }

    def self.tile(slime:, x:, y:, type:, key:)
      path = FILE_PATH + FILE_MAP[type]
      tile_x, tile_y = tile_asset_position(key)

      frames_in_sprite_sheet = 6
      ticks_per_frame = 8
      repeat_index = true
      tile_index = slime.started_running_at
                        .frame_index(frames_in_sprite_sheet,
                                    ticks_per_frame,
                                    repeat_index)

      {
        x: x,
        y: y,
        w: TILE_SIZE,
        h: TILE_SIZE,
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
