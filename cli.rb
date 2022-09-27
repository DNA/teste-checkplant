module Cli
  include TTY::Option

  usage do
    no_command

    desc "Valida o tempo de preparo do miojo usando duas ampulhetas"

    example "miojo 3 5 7"
  end

  argument :miojo do
    required
    convert :int
    validate { _1 > 0 }
    desc "O tempo de cozimento do miojo."
  end

  argument :ampulheta1 do
    required
    convert :int
    validate { _1 > 0 && _1 < params[:miojo] }
    desc "Tempo da primeira ampulheta."
  end

  argument :ampulheta2 do
    required
    convert :int
    validate { _1 > 0 && _1 < params[:miojo] }
    desc "Tempo da segunda ampulheta."
  end

  flag :help do
    short "-h"
    long "--help"
    desc "Exibe o texto de ajuda"
  end
end
