class Entry
  attr_accessor :val, :possibles

  def initialize(val)
    raise "Invalid number: #{val}" unless 0 <= val && val <= 9
    @val = val
    init_possibles!
  end

  def set_possibles(*possibles)
    return if @val != 0
    @possibles = possibles
    auto_set_val!
  end

  def remove_from_possible(*possible_val)
    return if @val != 0
    @possibles -= possible_val
    auto_set_val!
  end

  def print_top_possibles
    return print_val_in_top_position if @val != 0
    str = ""
    str << (@possibles.include?(1) ? "1" : " ")
    str << (@possibles.include?(2) ? "2" : " ")
    str << (@possibles.include?(3) ? "3" : " ")
    str
  end

  def print_middle_possibles
    return print_val_in_middle_position if @val != 0
    str = ""
    str << (@possibles.include?(4) ? "4" : " ")
    str << (@possibles.include?(5) ? "5" : " ")
    str << (@possibles.include?(6) ? "6" : " ")
    str
  end

  def print_bottom_possibles
    return print_val_in_bottom_position if @val != 0
    str = ""
    str << (@possibles.include?(7) ? "7" : " ")
    str << (@possibles.include?(8) ? "8" : " ")
    str << (@possibles.include?(9) ? "9" : " ")
    str
  end

  private

  def auto_set_val!
    if @possibles.size == 1
      @val = @possibles.first
    end
  end

  def print_val_in_top_position
    case @val
      when 1 then "1  "
      when 2 then " 2 "
      when 3 then "  3"
      else "   "
    end
  end

  def print_val_in_middle_position
    case @val
      when 4 then "4  "
      when 5 then " 5 "
      when 6 then "  6"
      else "   "
    end
  end

  def print_val_in_bottom_position
    case @val
      when 7 then "7  "
      when 8 then " 8 "
      when 9 then "  9"
      else "   "
    end
  end

  def val=(val)
    raise "Invalid number: #{val}" unless 1 <= val && val <= 9
    @val = val
  end

  def init_possibles!
    if @val != 0
      @possibles = []
    else
      @possibles = [1,2,3,4,5,6,7,8,9] - [@val]
    end
  end
end
