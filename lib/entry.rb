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

  private

  def auto_set_val!
    if @possibles.size == 1
      @val = @possibles.first
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
