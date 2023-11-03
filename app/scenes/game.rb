require "app/scenes/game/camera"
require "app/scenes/game/level"

module Scenes
  module Game
    def self.tick(args)
      Scenes::Game::Camera.tick(args)
      Scenes::Game::Level.tick(args)
      render_player(args)
      args.state.enemies ||= []
      args.state.dying_enemies ||= []
      args.state.kill_count ||= 0

      args.state.enemies = generate_enemies(args) if args.state.enemies.empty?
      update_enemies(args)

      # 1. Find the closest enemy to player within a set radius
      if enemy = find_closest_enemy(args, 150)
        enemy.take_damage(args, args.state.player.weapon.attack(args, enemy.x, enemy.y))
        # enemy.take_damage(args, Weapons::Scratch.attack(args, enemy.x, enemy.y))
        # Weapons::Laser.attack(args, enemy.x, enemy.y)
        # Weapons::Feather.attack(args, enemy.x, enemy.y)

        # destroy enemy from pool of enemies
        if enemy.dead?
          args.state.dying_enemies << args.state.enemies.delete(enemy)
          args.state.kill_count += 1
          if args.state.kill_count % 30 == 0
            args.state.player.level += 1
            puts args.state.player.level
          end
        end
      else
        if (args.state.player.weapon == Weapons::Feather) || (args.state.player.weapon == Weapons::Laser)
          args.state.player.weapon.scout(args)
        end
      end

    end

    def self.reset(args)
      Scenes::Game::Level.reset(args)
      Scenes::Game::Player.reset(args)
      args.state.enemies = []
      args.state.kill_count = 0
    end

    def self.render_player(args)
      Scenes::Game::Player.init(args)
      Scenes::Game::Player.handle_movement(args)
      # Scenes::Game::Player.level_up(args)
    end

    def self.update_enemies(args)
      args.state.enemies.each do |enemy|
        enemy.move(args, args.state.player.x, args.state.player.y)

        if args.geometry.intersect_rect?(enemy, args.state.player)
          if (args.tick_count/20).to_i % 2 == 0 # to do: see if this is too frequent or not frequent enough for enemies to damage player
            Scenes::Game::Player.take_damage(args, enemy)
            puts "cat is hurt!"
          end
        end
      end

      args.state.dying_enemies.delete_if { |enemy| !enemy.animate_dying_in_progress?(args) }
    end

    def self.generate_enemies(args)
      srand
      random_amount = rand(10) * (args.state.player.level/2).to_i
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
