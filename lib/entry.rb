class Entry
  attr_accessor :val, :possibles

  def initialize(val)
    raise "Invalid number: #{val}" unless 0 <= val && val <= 9
    @val = val
    init_possibles!
  end

  def set_possibles(*possibles)
    @possibles = possibles
  end

  def remove_from_possible(*possible_val)
    @possibles -= possible_val
  end

  private

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
