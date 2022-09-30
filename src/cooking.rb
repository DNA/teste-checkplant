
class Cooking
  attr_accessor :hourglasses
  attr_reader :time, :errors

  def initialize(time)
    @hourglasses = []
    @errors = []
    @time = time
  end

  def valid?
    if hourglasses.size != 2
      @errors << "You must provide two hourglasses."
    end

    if hourglasses.any? { _1 <= @time }
      @errors << "Hourglasses must be greater than the cooking time."
    end

    if time < 1
      @errors << "Cooking time must be greater than 1 minute."
    end

    @errors.empty?
  end

  def time_total
    hg1, hg2 = hourglasses.minmax

    loop do
      diff  = hg2 - hg1

      break if diff.magnitude == time

      case hg1 <=> hg2
      when  1 then hg2.turn
      when  0 then return 0
      when -1 then hg1.turn
      end
    end

    [hg1, hg2].max
  end
end
