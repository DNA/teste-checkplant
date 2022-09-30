require "minitest/autorun"

require_relative '../src/hourglass'

class HourglassTest < Minitest::Test
  def setup
    @hg = Hourglass.new(5)
  end

  def test_to_integer
    assert @hg.to_i, 5
  end

  def test_to_string
    assert @hg.to_s, "5"
  end

  def test_subtraction
    assert @hg - 1, 4
  end

  def test_spaceship
    assert @hg <=> 1, -1
    assert @hg <=> 5, 0
    assert @hg <=> 9, 1
  end

  def test_turn
    @hg.turn

    assert @hg.to_i, 10
  end
end
