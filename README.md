# README

## Requirements / Versions

- Ruby: 3.0.2
- Rails: 6.1.4
- Node: v12.18.3
- DB: MySQL, tested with 8.0.26

## Install process

Make sure you have correct ruby, node and MySQL installed

- Install the gems with `bundle install`
- Install require node packages (we are using webpacker) with `yarn install`
- The DB creadentials are defaulted to `root` / `root` however `DEV_DATABASE_USERNAME` and `DEV_DATABASE_PASSWORD` env vars can be set in order to change this defaults
- Create dev DB with `bundle exec rake db:create`
- Run migrations with `bundle exec rake db:migrate`
- Run the server with `bundle exec rails s -p 3000`

App should be accessible from [http://localhost:3000](http://localhost:3000)