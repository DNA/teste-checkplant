module CliOptionParser
  def self.included(base)
    base.class_eval do
      include TTY::Option

      usage do
        desc "Valida o tempo de preparo do miojo usando duas ampulhetas"
      
        example <<~EOS
          miojo -m3 -a5 -a7
          miojo --miojo 3 --ampulheta=5,7
          miojo --miojo 3 --ampulheta=5 --ampulheta=7
        EOS
      end
      
      option :miojo do
        required
        short "-m"
        convert :int
        validate { _1 > 0 }
        desc "O tempo de cozimento do miojo, em minutos."
      end
      
      option :ampulheta do
        required
        arity 2
        short "-a"
        long  "--ampulheta tempos"
        convert :int_list
        validate { _1 > 0 }
        desc <<~DESC
          Informa os valores das ampulhetas em minutos.
          Pode ser informado multiplas vezes ou em uma lista separada por vírgula.
        DESC
      end
      
      flag :help do
        short "-h"
        long "--help"
        desc "Exibe o texto de ajuda"
      end
    end
  end
end



