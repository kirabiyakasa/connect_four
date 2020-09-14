class Game
  def initialize(interface, players)
    @interface = interface
    @board = Board.new
    @players = players
    @player_names = [players[0].name, players[1].name]
    @player_colors = [players[0].color, players[1].color]
  end

  def play_game(game)
    matched_four = false

    @players.each do |player|
      @interface.show_board(@board.columns, @player_names, @player_colors)
      puts "\n#{player.name}'s turn."
      move_coords = get_move(game)
      matched_four = @board.update_board(player.color, move_coords)
      if matched_four == true
        @interface.show_board(@board.columns, @player_names, @player_colors)
        @interface.show_victory(player.name, player.color)
        end_game(@interface, @players)
      end
      check_board()
    end
    play_game(game)
  end

  private
  def get_move(game)
    input = gets.chomp
    until input == "0" || ("1".."7").include?(input) && 
      @board.columns[input.to_i - 1][0] == " "

      puts "Please Enter a valid input."
      input = gets.chomp
    end

    input = input.to_i
    input == 0 ? save_game(game) : move = get_coords(input - 1)
    return move
  end

  def get_coords(x)
    column = @board.columns[x]
    y = 0
    until column[y] == "●" || column[y] == "○" || column[y] == nil
      y += 1
    end
    y -= 1
    return x, y
  end

  def check_board()
    if @board.columns.values.join.include?(" ") == false
      puts "\nTie!"
      end_game(@interface, @players)
    end
  end

  def end_game(interface, players)
    puts "\nWould you like to play again?"
    puts "1) Yes    2) No"
    answer = gets.chomp
    until ["1", "2", "y", "n"].include?(answer)
      puts "\nPlease Enter a valid input."
      answer = gets.chomp
    end
    if answer == "1" || answer == "y"
      game = Game.new(interface, players)
      game.play_game(game)
    else
      start_game()
    end
  end

  def save_game(game)
    saved_game = YAML.dump(game)
    save_file = "save_file.yml"
  
    File.open(save_file, 'w') do |file|
      file.write saved_game
    end
    start_game()
  end

end
