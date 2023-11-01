module Scenes
  module Game
    def self.tick(args)
      render_background(args)
      render_player(args)
    end

    def self.render_background(args)
      rows = (SCREEN_WIDTH / Sprites::Terrain::SPRITE_SIZE).ceil
      cols = (SCREEN_HEIGHT / Sprites::Terrain::SPRITE_SIZE).ceil

      rows.times do |row|
        cols.times do |col|
          x = row * Sprites::Terrain::SPRITE_SIZE
          y = col * Sprites::Terrain::SPRITE_SIZE

          type = Sprites::Terrain::FILE_MAP.keys[row % Sprites::Terrain::FILE_MAP.keys.length]
          key = Sprites::Terrain::TILE_MAP.keys[col % Sprites::Terrain::TILE_MAP.length]

          args.outputs.sprites << Sprites::Terrain.tile(x: x, y: y, type: type, key: key)
        end
      end
    end

    def self.render_player(args)
      args.outputs.sprites << Sprites::Player.tile(x: 100, y: 100, type: "cat_1", key: "down_still")
    end
  end
end
