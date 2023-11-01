module Scenes
  module Game
    def self.tick(args)
      render_background(args)
      render_player(args)
      render_enemies(args)
      # handle_input(args)
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
      # args.outputs.sprites << Sprites::Player.tile(x: 100, y: 100, type: "cat_1", key: "down_still")
      player = Scenes::Game::Player.new(args)
      player.render(args)
      player.handle_movement(args)
      # args.state.player ||= Scenes::Game::Player.new(args)
    end

    # def self.handle_input(args)
    #   if args.inputs # change later to make this only for up, down, left, right--other inputs may do a menu or something
    #     Scenes::Game::PlayerMovement.tick(args)
    #   end
    # end

    def self.render_enemies(args)
      args.state.enemies ||= generate_enemies(args)
      args.state.enemies.each { |enemy| enemy.render(args) }
    end

    def self.generate_enemies(args)
      amount = rand(10)
      enemies = []

      amount.times do
        enemies << Enemies::Slime.new(args)
      end
      enemies
    end
  end
end
