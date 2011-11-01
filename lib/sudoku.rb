class Sudoku
  QUAD_INDEX_TO_SPACES = {
    0 => [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]],
    1 => [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]],
    2 => [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]],
    3 => [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]],
    4 => [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]],
    5 => [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]],
    6 => [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]],
    7 => [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]],
    8 => [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]
  }

  def initialize(board_str)
    @board = []
    create_board(board_str)
    validate_board
  end

  def print_board
    @board.each_index do |i|
      p @board[i].join(" ")
    end
  end

  private

  def validate_board
    (0..8).each do |i|
      validate_row_by_index(i)
      validate_col_by_index(i)
      validate_quadrant_by_index(i)
    end
  end

  def validate_row_by_index(index)
    raise "More than 1 number for row #{index} - #{@board[index].inspect}" unless uniq_row?(@board[index])
  end

  def validate_col_by_index(index)
    col = []
    (0..8).each do |i|
      col << @board[i][index]
    end
    raise "More than 1 number for col #{index} - #{col.inspect}" unless uniq_row?(col)
  end

  def validate_quadrant_by_index(index)
    quad = []
    QUAD_INDEX_TO_SPACES[index].each do |row, col|
      quad << @board[row][col]
    end
    raise "More than 1 number for quad #{index} - #{quad.inspect}" unless uniq_row?(quad)
  end

  def uniq_row?(row)
    (row - [0]).size == (row - [0]).uniq.size
  end

  def create_board(board_str)
    board_str.gsub!(/\s/, "")
    board_array = board_str.split(",")
    raise "Not enough numbers" if board_array.size != 81
    (0..8).each do |i|
      row = Array.new
      (0..8).each do |j|
        row << board_array.shift.to_i
      end
      @board << row
    end
  end
end