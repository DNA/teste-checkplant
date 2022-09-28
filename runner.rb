require_relative 'cooking'
require_relative 'cli'

class Runner
  def initialize(cli = Cli, cooking = Cooking)
    @cli = cli
    @cooking = cooking
  end

  def run
    @cli.run do |params|
      cooking = @cooking.new(params[:noodles])
    
      cooking.hourglasses << params[:hourglass1]
      cooking.hourglasses << params[:hourglass2]
    
      unless cooking.valid?
        cooking.errors.each { puts _1 }
    
        exit 3
      end
    
      time = cooking.time_total
    
      if time.zero?
        puts "You can't cook this noodles with these hourglasses."
      else
        puts "Total cooking time: #{cooking.time_total.to_i} minutes"
      end
    end
  end
end