require 'bundler'

Bundler.require

require_relative 'cooking'
require_relative 'hourglass'
require_relative 'cli'

class Runner
  def initialize(cli = Cli, cooking = Cooking)
    @cli = cli
    @cooking = cooking
  end

  def run
    @cli.run do |params|
      cooking = @cooking.new(params[:noodles])
        .tap do |c|
          c.hourglasses << Hourglass.new(params[:hourglass1])
          c.hourglasses << Hourglass.new(params[:hourglass2])
        end
    
      unless cooking.valid?
        cooking.errors.each { $stderr.puts _1 }
    
        exit 3
      end
    
      time = cooking.time_total
    
      if time.zero?
        puts "You can't cook this noodles with these hourglasses."
      else
        puts "Total cooking time: #{cooking.time_total} minutes"
      end
    end
  end
end
