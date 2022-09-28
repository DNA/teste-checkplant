require "bundler"

Bundler.require

require_relative '../cli'

class CliTest < BaseTest
  def setup
    @cli = Cli.new
  end

  def run_cli_with(params)
    capture_io do
      @cli.parse(params)
      @cli.run
    rescue SystemExit
    end
  end

  def test_all_arguments_passed
    _, stderr = run_cli_with(%w[3 5 7])

    assert_match '', stderr
  end

  def test_missing_hourglass2
    _, stderr = run_cli_with(%w[1 2])

    assert_match (/argument 'hourglass2' must be provided/) , stderr
  end

  def test_missing_hourglass1
    _, stderr = run_cli_with(%w[1])

    assert_match (/Argument 'hourglass2' must be provided/), stderr
    assert_match (/Argument 'hourglass1' must be provided/), stderr
  end

  def test_missing_cooking_time
    _, stderr = run_cli_with([])

    assert_match (/Argument 'hourglass2' must be provided/), stderr
    assert_match (/Argument 'hourglass1' must be provided/), stderr
    assert_match (/Argument 'noodles' must be provided/), stderr
  end

  def test_help
    stdout, _ = run_cli_with(['-h'])

    assert_match (/Usage: /), stdout
    assert_match (/Show this help message./), stdout
  end
end
