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

  def initialize(board_str, debug=false)
    @board = []
    @set = false
    @debug = debug
    create_board(board_str)
    validate_board
    set_possibles
  end

  def possibles(row_index, col_index)
    @board[row_index][col_index].possibles
  end

  def solve!
    @set = true
    @counter = 1
    while(@set)
      set_possibles
      print_board if @debug
      @counter += 1
    end
    @counter
  end

  def print_board
    puts ""
    @board.each_index do |i|
      p convert_entries_to_number(@board[i]).join(" ")
    end
  end

  def valid_final_board?
    (0..8).each do |i|
      if !(get_possibles_for_row_index(i) - [1,2,3,4,5,6,7,8,9]).empty? ||
         !(get_possibles_for_col_index(i) - [1,2,3,4,5,6,7,8,9]).empty? ||
         !(get_possibles_for_quadrant_index(i) - [1,2,3,4,5,6,7,8,9]).empty?
        return false
      end
    end
    return true
  end

  private

  def find_quad_by_entry(row, col)
    if row < 3
      if col < 3
        return 0
      elsif col < 6
        return 1
      else
        return 2
      end
    elsif row < 6
      if col < 3
        return 3
      elsif col < 6
        return 4
      else
        return 5
      end
    else
      if col < 3
        return 6
      elsif col < 6
        return 7
      else
        return 8
      end
    end
  end

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
    col = find_all_entries_in_col_index(index)
    raise "More than 1 number for col #{index} - #{col.inspect}" unless uniq_row?(col)
  end

  def get_possibles_for_row_index(index)
    convert_entries_to_number(@board[index])
  end

  def get_possibles_for_col_index(index)
    col = find_all_entries_in_col_index(index)
    convert_entries_to_number(col)
  end

  def get_possibles_for_quadrant_index(index)
    quad = find_all_entries_in_quad_index(index)
    convert_entries_to_number(quad)
  end

  def validate_quadrant_by_index(index)
    quad = find_all_entries_in_quad_index(index)
    raise "More than 1 number for quad #{index} - #{quad.inspect}" unless uniq_row?(quad)
  end

  def find_all_entries_in_col_index(index)
    col = []
    (0..8).each do |i|
      col << @board[i][index]
    end
    col
  end

  def find_all_entries_in_quad_index(index)
    quad = []
    QUAD_INDEX_TO_SPACES[index].each do |row, col|
      quad << @board[row][col]
    end
    quad
  end

  def uniq_row?(row)
    row = convert_entries_to_number(row)
    (row - [0]).size == (row - [0]).uniq.size
  end

  def convert_entries_to_number(entries)
    entries.map(&:val)
  end

  def create_board(board_str)
    board_str.gsub!(/\s/, "")
    board_array = board_str.split(",")
    raise "Not enough numbers" if board_array.size != 81
    (0..8).each do |i|
      row = Array.new
      (0..8).each do |j|
        row << Entry.new(board_array.shift.to_i)
      end
      @board << row
    end
  end

  def get_possibles(uniq_nums)
    [1,2,3,4,5,6,7,8,9] - uniq_nums
  end

  def set_possibles
    @set = false
    (0..8).each do |i|
      (0..8).each do |j|
        next if @board[i][j].val != 0
        rows = get_possibles_for_row_index(i)
        cols = get_possibles_for_col_index(j)
        quads = get_possibles_for_quadrant_index(find_quad_by_entry(i,j))
        all_nums = [rows + cols + quads].flatten.uniq
        # if (i == 4 && j == 3)
        #   p "***** rows #{rows.inspect}"
        #   p "***** cols #{cols.inspect}"
        #   p "***** quads #{quads.inspect}"
        #   p "***** quads #{quads.inspect}"
        #   p "**** all is #{all_nums.inspect}"
        # end
        possibles = get_possibles(all_nums)
        if possibles.size <= 1
          @set = true
        end
        @board[i][j].set_possibles(*possibles)
      end
    end
  end
end