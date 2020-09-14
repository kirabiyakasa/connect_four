class Board
  attr_reader :columns
  def initialize()
    @columns = build_board()
  end

  def update_board(color, move_coords)
    x = move_coords[0]
    y = move_coords[1]
    @columns[x][y] = color
    matched_four = check_win_conditions(move_coords)
    return matched_four
  end

  private
  def build_board()
    i = 0
    board = {}
    while i < 7
      board[i] = [" ", " ", " ", " ", " ", " "]
      i += 1
    end
    return board
  end

  def check_win_conditions(move_coords)
  
    diag = get_diagonal(move_coords)
    vertical = get_vertical(move_coords)
    horizontal = get_horizontal(move_coords)
    matched_four = check_lines([diag[0], diag[1], vertical, horizontal])
  
    return matched_four
  end

  def check_lines(lines)
    lines.each do |line|
      if line.join.include?("●●●●")
        return true
      elsif line.join.include?("○○○○")
        return true
      end
    end
    return false
  end

  def get_diagonal(move_coords)
    diag_axes = { 0 => [], 1 => []}
    x, y = move_coords[0], move_coords[1]
    until x == 0 || y == 0
      x -= 1
      y -= 1
    end
    while (0..6).include?(x) && (0..5).include?(y)
      diag_axes[0] << @columns[x][y]
      x += 1
      y += 1
    end
    x, y = move_coords[0], move_coords[1]
    until x == 0 || y == 5
      x -= 1
      y += 1
    end
    while (0..6).include?(x) && (0..5).include?(y)
      diag_axes[1] << @columns[x][y]
      x += 1
      y -= 1
    end
    return diag_axes
  end

  def get_vertical(move_coords)
    x = move_coords[0]
    return @columns[x]
  end

  def get_horizontal(move_coords)
    x = 0
    y = move_coords[1]
    horizontal_axis = []
    until x == 7
      horizontal_axis << @columns[x][y]
      x += 1
    end
    return horizontal_axis
  end

end
