require "minitest/autorun"

require_relative '../src/cooking'
require_relative '../src/hourglass'

class CookingTest < Minitest::Test
  POSSIBLE_STATES = {
    # Casos comuns
    [3, 5,  7] => 10, # impar | impar | impar
    [3, 5,  6] => 15, # impar | impar |   par
    [3, 6,  7] => 21, # impar |   par | impar
    [3, 6, 10] =>  0, # impar |   par |   par

    [2, 5,  9] => 20, #   par | impar | impar
    [2, 5,  6] => 12, #   par | impar |   par
    [2, 6,  7] => 14, #   par |   par | impar
    [2, 6, 10] => 12, #   par |   par |   par

    # Casos onde a diferença dos tempos é igual ao tempo de cozimento
    [3, 5,  8] =>  8, #   par |   par | impar
    [3, 6,  9] =>  9, #   par | impar |   par
    [4, 5,  9] =>  9, #   par |   par | impar
    [4, 8, 12] => 12, #   par | impar |   par

    # Caso onde a diferença entre os tempos é cíclica
    [3, 5, 10] =>  0,
    [2, 4,  8] =>  0,
  }

  def create_cooking(time = 0, hg1 = nil, hg2 = nil)
    Cooking.new(time).tap do |c|
      c.hourglasses << Hourglass.new(hg1) if hg1
      c.hourglasses << Hourglass.new(hg2) if hg2
    end
  end

  def test_cooking_time_less_than_one
    cooking = create_cooking

    refute cooking.valid?
    assert_includes cooking.errors, 'Cooking time must be greater than 1 minute.'
  end

  def test_cooking_time_more_than_one
    cooking = create_cooking(3)
    cooking.valid?

    refute_includes cooking.errors, 'Cooking time must be greater than 1 minute.'
  end

  def test_hourglass_time_less_than_cooking_time
    cooking = create_cooking(3, 1)

    refute cooking.valid?
    assert_includes cooking.errors, 'Hourglasses must be greater than the cooking time.'
  end

  def test_single_hourglass
    cooking = create_cooking(3, 10)

    refute cooking.valid?
    assert_includes cooking.errors, 'You must provide two hourglasses.'
  end

  def test_valid_values
    cooking = create_cooking(3, 5, 7)

    assert cooking.valid?
    assert_empty cooking.errors
  end

  class_eval do
    POSSIBLE_STATES.each do |times, expected_value|
      time, hg1, hg2 = times
      define_method(:"test_time_#{time}_and_hourglasses_#{hg1}_and_#{hg2}") do
        cooking = create_cooking(time, hg1, hg2)

        assert cooking.valid?
        assert_equal expected_value.to_i, cooking.time_total.to_i
      end
    end
  end
end
