require "minitest/autorun"

require_relative '../src/runner'

class RunnerTest < Minitest::Test

  def runner_instance(params)
    cli = Cli.new
    cli.parse(params)

    Runner.new(cli)
  end

  def test_validate_cooking
    assert_output('', /Hourglasses must be greater than the cooking time/) do
      assert_raises(SystemExit) { runner_instance(%w[4 4 2]).run }
    end
  end

  def test_with_time
    assert_output(/10 minutes/) { runner_instance(%w[3 5 7]).run }
  end

  def test_without_time
    assert_output(/can't cook this noodles/) { runner_instance(%w[3 4 8]).run }
  end
end
