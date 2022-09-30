class Hourglass < Numeric
  include Comparable

  def initialize(time)
    @time = time
    @turns = 1
  end

  def turn
    @turns += 1
  end

  def to_i
    @time * @turns
  end

  def to_s
    to_i.to_s
  end

  def <=>(other)
    to_i <=> other.to_i
  end

  def -(other)
    to_i - other.to_i
  end
end
