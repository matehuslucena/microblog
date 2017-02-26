# MICROBLOG

Aplicação desenvolvido para ser um microblog pessoal, onde o usuário pode escrever pequenos textos e compartilhar com os outros usuário
cadastrados.

Stack da aplicação:
- Rails 5
- Ruby 2.3.3
- Postgres

Para instalar a aplicação faça um clone do repositório, entre no diretório e rode o comando `bundle install` para instalar as dependências do
projeto.

Após rodar o comando acima abra o arquivo `config\database.yml` e altera as configurações de usuário e senha
configuradas no eu postgres. Após configurar os acessos ao banco execute `rails db:create db:migrate` para criar o banco e as tabelas.

Após esses passos erga o servidor local com o comando `rails s` e pronto é só acessar o sistema através da url `http://localhost:3000`.

O sistema pode ser acessado através da url `http://microblog-helabs.herokuapp.com`
 
