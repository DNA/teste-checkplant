# Testes Checkplant

## Instalação

Após baixar o repositório, basta instalar as gems via `Bundler`

```shell
$ bundle install
```

## Testes

O MiniTest foi escolhido por não depender de uma DSL para escrever os testes, como no caso do Rspec, o que facilitar analizar a lógica dos testes utilizados.

Para rodá-los basta rodar o comando abaixo:

```shell
$ rake -t
```

## Miojo

### Execução

Basta chamar o executável passando os parametros necessários:
```shell
$ bin/noodles 3 5 7
```

Também pode ser utilizado a opção `-h` para visualizar a ajuda do comando:

```shell
$ bin/noodles -h
```

### Estrutura

Decidi por não utilizar a estrutura das gems neste caso para diminuir a quantidade de arquivos gerados e facilitar o review.

Da mesma forma, foi utilizada a gem `tty-option` para facilitar a coleta dos dados, considerando que o foco estava na resolução do problema.

## Vetores

### Execução

Basta executar o commando `vectors` passando o caminho de um arquivo que possua os dados dos vatores.

```shell
$ bin/vectors path/to/file
```
Um arquivo de exemplo pode ser encontrado em `test/fixtures/vectors`

### Estrutura

Neste teste optei por criar um script mais "direto ao ponto", utilizando a classe `Vector` do Ruby e processando os dados recebidos diretamente pelo `ARGV`.

Como o cálculo da distância é bem direta ao ponto, foquei na forma de exibição dos dados, utilizando a gem `tty-table` para produzir uma tabela que facilitasse a leitura na linha de comando. Também poderia fácilmente ser implementado outro render, para retornas os dados como um `JSON`, por exemplo 