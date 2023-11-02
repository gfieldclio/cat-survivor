require "app/scenes/game/camera"
require "app/scenes/game/level"

module Scenes
  module Game
    def self.tick(args)
      Scenes::Game::Camera.tick(args)
      Scenes::Game::Level.tick(args)
      render_player(args)
      args.state.enemies ||= []
      args.state.kill_count ||= 0

      args.state.enemies = generate_enemies(args) if args.state.enemies.empty?
      move_enemies(args)

      # 1. Find the closest enemy to player within a set radius
      if enemy = find_closest_enemy(args, 150)
        enemy.take_damage(Weapons::Scratch.attack(args, enemy.x, enemy.y), args)
        Weapons::Laser.attack(args, enemy.x, enemy.y)
        Weapons::Feather.attack(args, enemy.x, enemy.y)

        # destroy enemy from pool of enemies
        if enemy.dead?
          args.state.enemies.delete(enemy)
          args.state.kill_count += 1
          if args.state.kill_count % 30 == 0
            args.state.player.level += 1
          end
        end
      else
        Weapons::Laser.scout(args)
        Weapons::Feather.scout(args)
      end
    end

    def self.render_player(args)
      Scenes::Game::Player.render(args)
      Scenes::Game::Player.handle_movement(args)
      # Scenes::Game::Player.level_up(args)
    end

    def self.move_enemies(args)
      args.state.enemies.each do |enemy|
        enemy.move(args.state.player.x, args.state.player.y, args)

        if args.geometry.intersect_rect?(enemy, args.state.player)
          #todo: only hurt the cat once, or every few seconds at least--this is hurting the cat lots
          Scenes::Game::Player.take_damage(args, enemy)
        end
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

    def self.find_closest_enemy(args, radius)
      enemies_within_radius = args.state.enemies.select {|enemy| distance_to(args, enemy.x, enemy.y) <= radius }
      enemies_within_radius.min_by { |enemy| distance_to(args, enemy.x, enemy.y) }
    end

    def self.distance_to(args, enemy_x, enemy_y)
      Math.sqrt((enemy_x - args.state.player.x)**2 + (enemy_y - args.state.player.y)**2)
    end
  end
end
