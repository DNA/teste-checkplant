class Cli
  include TTY::Option

  usage do
    no_command

    desc "Return the noodles cooking time when using two hourglasses to measure time"

    example "miojo 3 5 7"
  end

  argument :noodles do
    required
    convert :int
    validate { _1 > 0 }
    desc "Noodles cooking time."
  end

  argument :hourglass1 do
    required
    convert :int
    validate { _1 > 0 }
    desc "First hourglass time."
  end

  argument :hourglass2 do
    required
    convert :int
    validate { _1 > 0 }
    desc "Second hourglass time."
  end

  flag :help do
    short "-h"
    long "--help"
    desc "Show this help message."
  end

  def self.run(...)
    new.then(&:parse).run(...)
  end

  def run
    if params[:help]
      puts help
      exit 0
    end

    if params.valid?
      yield params if block_given?
    else
      $stderr.puts params.errors.summary
      exit 2
    end
  end
end
