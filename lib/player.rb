class Player
  attr_reader :name, :color
  def initialize(colors)
    @name = get_name()
    @color = choose_color(colors)
  end

  private
  def get_name()
    name = gets.chomp
    return name
  end

  def choose_color(colors)
    if colors.length == 2
      puts "\nSelect a Color for Player 1."
      puts "\n1) Black    2) White"
      answer = gets.chomp
      until answer == "1" || answer == "2"
        puts "\nPlease Enter a valid input."
        answer = gets.chomp
      end
      answer == "1" ? color = colors.shift : color = colors.pop
    else
      color = colors.pop
    end
    return color
  end

end
