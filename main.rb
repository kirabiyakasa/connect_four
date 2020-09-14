require 'yaml'
require './lib/board.rb'
require './lib/game.rb'
require './lib/interface.rb'
require './lib/player.rb'

def get_input()
  input = gets.chomp
  until input == "1" || input == "2"
    "Please Enter a valid input."
    answer = gets.chomp
  end
  return input
end

def load_game(interface)
  begin
    game = YAML.load(File.read("save_file.yml"))
    game.play_game(game)
  rescue
    new_game(interface)
  end
end

def new_game(interface)
  colors = ["○", "●"]
  puts "Enter name for Player 1."
  player1 = Player.new(colors)
  puts "Enter name for player 2."
  player2 = Player.new(colors)
  game = Game.new(interface, [player1, player2])
  game.play_game(game)
end

def start_game()
  interface = Interface.new
  interface.show_rules
  interface.show_new_game
  answer = get_input()
  if answer == "1"
    new_game(interface)
  elsif answer == "2"
    load_game(interface)
  end
end
start_game()
