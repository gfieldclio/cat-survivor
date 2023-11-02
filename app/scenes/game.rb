module Scenes
  module Game
    def self.tick(args)
      render_background(args)
      render_player(args)

      args.state.enemies ||= generate_enemies(args)
      move_enemies(args)
    end

    def self.render_background(args)
      rows = (SCREEN_WIDTH / Sprites::Terrain::Ground::SPRITE_SIZE).ceil
      cols = (SCREEN_HEIGHT / Sprites::Terrain::Ground::SPRITE_SIZE).ceil

      rows.times do |row|
        cols.times do |col|
          x = row * Sprites::Terrain::Ground::SPRITE_SIZE
          y = col * Sprites::Terrain::Ground::SPRITE_SIZE

          type = Sprites::Terrain::Ground::FILE_MAP.keys[row % Sprites::Terrain::Ground::FILE_MAP.keys.length]
          key = Sprites::Terrain::Ground::TILE_MAP.keys[col % Sprites::Terrain::Ground::TILE_MAP.length]
          side = [nil, "top", "bottom", "left", "right", "top_left", "top_right", "bottom_left", "bottom_right"][col % 9]

          puts "x: #{x}, y: #{y}, type: #{type}, key: #{key}, side: #{side}" if args.state.test.nil?
          args.outputs.sprites << Sprites::Terrain::Ground.tile(x: x, y: y, type: type, key: key, side: side)
        end
      end
      args.state.test = true
    end

    def self.render_player(args)
      # args.outputs.sprites << Sprites::Player.tile(x: 100, y: 100, type: "cat_1", key: "down_still")
      player = Scenes::Game::Player.new(args)
      player.render(args)
      player.handle_movement(args)
      # args.state.player ||= Scenes::Game::Player.new(args)
    end

    def self.move_enemies(args)
      args.state.enemies.each do |enemy|
        enemy.move(args.state.player.x, args.state.player.y, args)

        # todo: check if enemy intersects with player

      end

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
