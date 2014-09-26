# Salesforce Sample

Este guia destina-se apenas à instalação e execução do sistema em modo desenvolvimento.

## Instalação

O sistema utiliza a linguagem Ruby em sua versão 2.1.x, o framework Ruby on Rails em sua versão 4.1.x e banco de dados PostgreSQL em sua versão 9.3.x e banco de dados Redis em sua versão 2.2.x.

Clone o repositório:

    $ git clone git@github.com:fbazzarella/salesforce_sample.git
    $ cd salesforce_sample

Instale as dependências:

    salesforce_sample$ bundle install

## Configuração

Copie o arquivo `config/database.yml.example` para `config/database.yml` e preencha-o de acordo com suas configurações. Após, basta criar o banco e rodar as migrations:

    salesforce_sample$ rake db:create db:migrate

Copie o arquivo `config/environment_variables.rb.example` para `config/environment_variables.rb` e preencha-o com as variáveis de ambiente necessárias para rodar a aplicação.

## Execução

Agora basta iniciar o servidor para que o sistema esteja rodando:

    salesforce_sample$ rails server

Para rodar o Sidekiq, execute:

    salesforce_sample$ sidekiq

Nota: caso você faça deploy da aplicação no `Heroku`, o arquivo `Procfile` já está configurado e você apenas precisará adicionar o `Addon Redis To Go` e no mínimo `1 worker dyno` à sua conta para que o `Sidekiq` funcione normalmente.

## Testes

Os testes automatizados são escritos em RSpec e utilizam FactoryGirl para a criação de registros. Antes de rodar os testes, você precisará preparar o banco de dados:

    salesforce_sample$ rake db:test:prepare
    
Agora, rode os testes:

    salesforce_sample$ rspec spec/

### Atenção

É extremamente importante enviar ao repositório somente commits que estejam com todos os testes em verde. Essa atitude evita problemas no futuro, economizando tempo e paciência.
