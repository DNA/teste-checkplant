# Miojo

## Instalação

Após baixar o repositório, basta instalar as gems relativas ao projeto e executar o comando `noodles`:

```shell
$ bundle install
$ bin/noodles 3 5 7
```
Também pode ser utilizado a opção `-h` para visualizar a ajuda do comando:

```shell
$ bin/noodles -h
```

## Estrutura

Decidi por não utilizar a estrutura das gems neste caso para diminuir a quantidade de arquivos gerados e facilitar o review.

Da mesma forma, foi utilizada a gem `tty-option` para facilitar a coleta dos dados, considerando que o foco estava na resolução do problema.

## Testes

O MiniTest foi escolhido por não depender de uma DSL para escrever os testes, como no caso do Rspec, o que facilitar analizar a lógica dos testes utilizados.

Para rodá-los basta rodar o comando abaixo:

```shell
$ rake -t
```
