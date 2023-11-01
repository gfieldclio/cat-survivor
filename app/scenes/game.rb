module Scenes
  module Game
    def self.tick(args)
      render_background(args)
      render_player(args)

      args.state.enemies ||= generate_enemies(args)
      move_enemies(args)
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
          side = [nil, "top", "bottom", "left", "right", "top_left", "top_right", "bottom_left", "bottom_right"][col % 9]

          puts "x: #{x}, y: #{y}, type: #{type}, key: #{key}, side: #{side}" if args.state.test.nil?
          args.outputs.sprites << Sprites::Terrain.tile(x: x, y: y, type: type, key: key, side: side)
        end
      end
      args.state.test = true
    end

    def self.render_player(args)
      args.outputs.sprites << Sprites::Player.tile(x: 100, y: 100, type: "cat_1", key: "down_still")
    end

    def self.move_enemies(args)
      args.state.enemies.each { |enemy| enemy.move(args) }
    end

    def self.generate_enemies(args)
      random_amount = rand(10)
      random_amount = 1 if random_amount == 0
      enemies = []

      random_amount.times do
        enemies << Scenes::Game::Enemies::Slime.new(args)
      end
      enemies
    end
  end
end
