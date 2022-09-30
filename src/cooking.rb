
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

  # O tempo das ampulhetas para o miojo é baseado na equação:
  #
  # Tm = Va1 * Ta1 - Va2 * Ta2
  #
  # Onde: 
  #   Tm  = Tempo do miojo
  #   Ta1 = Tempo da ampulheta 1
  #   Ta2 = Tempo da ampulheta 2
  #   Va1 = Voltas necessárias na ampulheta 1
  #   Va2 = Voltas necessárias na ampulheta 2
  def time_total
    hg1, hg2 = hourglasses.minmax

    # Duas ampulhetas de tempo par não conseguem calcular um tempo impar
    return 0 if time.odd? && hg1.even? && hg2.even?
    return 0 if hg1 == hg2

    1.upto(100) do |va2|
      va1 = (time.to_f + va2 * hg2.to_f) / hg1.to_f

      return [va1 * hg1, va2 * hg2].max if va1 % 1 == 0
    end

    0
  end
end
