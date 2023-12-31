require "app/scenes/game/camera"
require "app/scenes/game/level"
require "app/scenes/game/stats"
require "app/scenes/game/weapon_selection"

module Scenes
  module Game
    def self.tick(args)
      Scenes::Game::Camera.tick(args)
      Scenes::Game::Level.tick(args)
      render_player(args)
      args.state.enemies ||= []
      args.state.dying_enemies ||= []
      args.state.exp ||= 0

      args.state.enemies = generate_enemies(args) if args.state.enemies.empty?
      update_enemies(args)

      # 1. Find the closest enemy to player within a set radius
      if enemy = find_closest_enemy(args, args.state.player.weapon.radius)
        enemy.take_damage(args, args.state.player.weapon.attack(args, enemy.x, enemy.y))
        # enemy.take_damage(args, Weapons::Scratch.attack(args, enemy.x, enemy.y))
        # Weapons::Laser.attack(args, enemy.x, enemy.y)
        # Weapons::Feather.attack(args, enemy.x, enemy.y)

        # destroy enemy from pool of enemies
        if enemy.dead?
          args.state.dying_enemies << args.state.enemies.delete(enemy)
          if enemy.type == "slime"
            args.state.exp += 10
          elsif enemy.type == "orc"
            args.state.exp += 25
          end

          if args.state.exp % 300 == 0
            args.state.player.level += 1
            if args.state.player.health <= 400
              args.state.player.health += 50
            end
          end
        end
      else
        if (args.state.player.weapon == Weapons::Feather) || (args.state.player.weapon == Weapons::Laser)
          args.state.player.weapon.scout(args)
        end
      end

      # Added this for debugging, but then for some reason collisions only work when I have this here... So made it transparent for now
      args.outputs.primitives << {x: args.state.player.x, y: args.state.player.y, w: args.state.player.w, h: args.state.player.h, anchor_x: args.state.player.anchor_x, anchor_y: args.state.player.anchor_y, r: 255, g: 0, b: 0, a: 0}.solid

      unlocked_weapons(args)

      Scenes::Game::WeaponSelection.handle_weapon_switch(args)
      Scenes::Game::WeaponSelection.render_icons(args)
      Scenes::Game::WeaponSelection.render_selection_arrow(args)
      Scenes::Game::WeaponSelection.render_instructions(args)
      Scenes::Game::Stats.tick(args)
    end

    def self.reset(args)
      Scenes::Game::Level.reset(args)
      Scenes::Game::Player.reset(args)
      args.state.enemies = []
      args.state.exp = 0
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
          end
        end
      end

      args.state.dying_enemies.delete_if { |enemy| !enemy.dying_in_progress?(args) }
    end

    def self.generate_enemies(args)
      srand
      random_amount = [1, rand(10)].max * (args.state.player.level/2).ceil
      enemies = []

      random_amount.times do
        enemies << Scenes::Game::Enemies::Slime.new(args)
      end

      # Add tougher enemies at higher levels
      if args.state.player.level >= 2
        num_of_orcs = [1, rand(3)].max * (args.state.player.level/2).ceil
        num_of_orcs.times do
          enemies << Scenes::Game::Enemies::Orc.new(args)
        end
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

    def self.unlocked_weapons(args)
      if args.state.player.level < 3
        args.state.player.unlocked_weapons = [Weapons::Scratch]
      elsif args.state.player.level < 5
        args.state.player.unlocked_weapons = [Weapons::Scratch, Weapons::Laser]
      elsif args.state.player.level >= 5
        args.state.player.unlocked_weapons = [Weapons::Scratch, Weapons::Laser, Weapons::Feather]
      end
    end
  end
end
