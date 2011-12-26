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

  def initialize(board_str=nil, debug=false)
    @board = []
    @set = false
    @debug = debug
    if board_str
      initialize_board(board_str)
    end
  end

  def possibles(row_index, col_index)
    @board[row_index][col_index].possibles
  end

  def set_board(board_str)
    raise "Board already set!" unless @board.empty?
    initialize_board(board_str)
  end

  def solve!
    raise "Board not set" if @board.empty?
    @set = true
    @counter = 1
    while(@set)
      go_through_board2
      print_board_with_possibles if @debug
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

  def print_board_with_possibles
    puts ""
    @board.each_index do |i|
      print_row_with_possibles(@board[i])
    end
  end

  def valid_final_board?
    (0..8).each do |i|
      if !(get_vals_for_row_index(i) - [1,2,3,4,5,6,7,8,9]).empty? ||
         !(get_vals_for_col_index(i) - [1,2,3,4,5,6,7,8,9]).empty? ||
         !(get_vals_for_quadrant_index(i) - [1,2,3,4,5,6,7,8,9]).empty?
        return false
      end
    end
    return true
  end

  private

  def initialize_board(board_str)
    create_board(board_str)
    validate_board
    go_through_board1
  end

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

  def get_vals_for_row_index(index)
    convert_entries_to_number(@board[index])
  end

  def get_vals_for_col_index(index)
    col = find_all_entries_in_col_index(index)
    convert_entries_to_number(col)
  end

  def get_vals_for_quadrant_index(index)
    quad = find_all_entries_in_quad_index(index)
    convert_entries_to_number(quad)
  end

  def get_possibles_for_row_index(index)
    convert_entries_to_possibles(@board[index])
  end

  def get_possibles_for_col_index(index)
    col = find_all_entries_in_col_index(index)
    convert_entries_to_possibles(col)
  end

  def get_possibles_for_quadrant_index(index)
    quad = find_all_entries_in_quad_index(index)
    convert_entries_to_possibles(quad)
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

  def convert_entries_to_possibles(entries)
    entries.map(&:possibles)
  end

  def print_row_with_possibles(row)
    p row.map(&:print_top_possibles).join("|")
    p row.map(&:print_middle_possibles).join("|")
    p row.map(&:print_bottom_possibles).join("|")
    p "---|---|---|---|---|---|---|---|---"
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

  def hidden_single?(all_possibles)
    hash = {}
    all_possibles.each do |val|
      if hash[val]
        hash[val] += 1
      else
        hash[val] = 1
      end
    end
    hash.invert[1]
  end

  def go_through_board1
    @set = false
    (0..8).each do |i|
      (0..8).each do |j|
        set_possibles(i,j)
      end
    end
  end

  def go_through_board2
    @set = false
    (0..8).each do |i|
      (0..8).each do |j|
        set_possibles(i,j)
        set_based_on_hidden_single(i,j)
      end
    end
  end

  def set_possibles(i,j)
    return if @board[i][j].val != 0
    rows = get_vals_for_row_index(i)
    cols = get_vals_for_col_index(j)
    quads = get_vals_for_quadrant_index(find_quad_by_entry(i,j))
    all_nums = [rows + cols + quads].flatten.uniq
    # if i == 1 && j == 0
    # p "***** rows #{rows.inspect}"
    # p "***** cols #{cols.inspect}"
    # p "***** quads #{quads.inspect}"
    # p "**** all is #{all_nums.inspect}"
    # end
    possibles = get_possibles(all_nums)
    if possibles.size <= 1
      @set = true
    end
    if !(@board[i][j].possibles - possibles).empty?
      @set = true
      @board[i][j].set_possibles(*possibles)
    end
  end

  # find hidden single
  # http://www.angusj.com/sudoku/hints.php
  def set_based_on_hidden_single(i,j)
    return if @board[i][j].val != 0
    rows = get_possibles_for_row_index(i)
    cols = get_possibles_for_col_index(j)
    quads = get_possibles_for_quadrant_index(find_quad_by_entry(i,j))
    uniq = hidden_single?(rows.flatten) or hidden_single?(cols.flatten) or hidden_single?(quads.flatten)
    # if i == 1 && j == 0
    # p "|||||***** rows #{rows.inspect}"
    # p "|||||***** cols #{cols.inspect}"
    # p "|||||***** quads #{quads.inspect}"
    # p "|||||**** all is #{all_possibles.inspect}"
    # p "***** uniq is #{uniq} with entry possibles #{@board[i][j].possibles}"
    # end
    if uniq && !([uniq] & @board[i][j].possibles).empty?
      @set = true
      @board[i][j].set_possibles(uniq)
    end
  end
end