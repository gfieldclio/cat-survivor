module Scenes
  module Game
    def self.tick(args)
      render_background(args)
      render_player(args)



      args.state.enemies ||= generate_enemies(args)
      move_enemies(args)

      # 1. Find the closest enemy to player within a set radius
      if enemy = find_closest_enemy(args, 150)
        enemy.take_damage(scratch_weapon(args, enemy.x, enemy.y), args)
        # destroy enemy from pool of enemies
        args.state.enemies.delete(enemy) if enemy.dead?
      end
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
      Scenes::Game::Player.render(args)
      Scenes::Game::Player.handle_movement(args)
    end

    def self.move_enemies(args)
      args.state.enemies.each do |enemy|
        enemy.move(args.state.player.x, args.state.player.y, args)
        # todo: check if enemy intersects with player
      end

    end

    def self.generate_enemies(args)
      random_amount = rand(10)
      random_amount = 5 if random_amount == 0
      enemies = []

      random_amount.times do
        enemies << Scenes::Game::Enemies::Slime.new(args)
      end
      enemies
    end

    def self.scratch_weapon(args, enemy_x, enemy_y)
      Weapons::Scratch.new(enemy_x, enemy_y).attack(args)
    end

    def self.find_closest_enemy(args, radius)
      enemies_within_radius = args.state.enemies.select {|enemy| distance_to(args, enemy.x, enemy.y) <= radius }
      enemies_within_radius.min_by { |enemy| distance_to(args, enemy.x, enemy.y) }
    end

    def self.distance_to(args, enemy_x, enemy_y)
      Math.sqrt((enemy_x - args.state.player.x)**2 + (enemy_y - args.state.player.y)**2)
    end
  end
end
