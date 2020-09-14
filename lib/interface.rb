class Interface

  def show_rules()
    puts "Rules:"
    puts "Press a corresponding Number key followed by the Enter key to \n" +
      "drop a colored piece in the column."
    puts "Pieces can be matched vertically, horizontally, and diagonally."
    puts "First player to match 4 in a row wins."
    puts "If board is filled and no matches are made, the game will end " + 
      "in a tie."
    puts "----------------------------\n"
  end

  def show_new_game()
    puts "\n      --------------      " +
         "\n      |Connect Four|      " +
         "\n      --------------      "
    puts "\n1) New Game    2) Load Game"
  end

  def show_board(board, names, colors)
    spaces = get_spaces(board)

    output = ""
    spaces.each_with_index do |space, i|

      output += "| #{space} "

      if i > 0 && (i + 1) % 7 == 0
        output += "|\n-----------------------------\n"
      end
    end
    puts "\n#{names[0]}: #{colors[0]}         0) Save Game"
    puts "#{names[1]}: #{colors[1]}\n"
    puts "\n  1   2   3   4   5   6   7  "
    puts output
  end

  def show_victory(player_name, color)
    color == "○" ? player_color = "Black" : player_color = "White"
    puts "\n\n#{player_name} matched 4 #{player_color} pieces!"
    puts "\n#{player_name} wins!"
  end

  private
  def get_spaces(board)
    i = 0
    spaces = []
    6.times do
      board.values.each do |column|
        spaces << column[i]
      end
      i += 1
    end
    return spaces
  end

end
