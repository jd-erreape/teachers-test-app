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

## Running the specs

Once the app has been installed we should be able to run our `RSpec` suite running:

- `bundle exec rake db:test:prepare`
- `bundle exec rspec spec`

## CI/CD

### Github actions

We have configured `Github Actions` in order to perform automatic checks regarding our project.

We have two actions running for every Pull Request and commit in master

- Spec task: Runs our `RSpec` test suite
- Rubocop task: Runs `Rubocop` against our project to ensure we adhere to community Ruby style guide

### Heroku app

We have also configured automatic deploys in Heroku everytime we merge into master and our CI is green, the app can be accessible in [Teachers Test App](https://teachers-test-app.herokuapp.com/) (initial load could be a bit slow given that Heroku free tier unload the app once it has not been accessed for a while)

### SimpleCov

We have installed `SimpleCov` in order to know which coverage we have achieved with our unit tests. At the moment of writing this readme we have **100% coverage** over our code. This can be checked accessing the latest `Spec Github Action` for `master` branch or running the spec suite locally

## Decisions made

We have tried to split the development of the task in small manageable Github issues (even though some ended up being a bit bigger than expected).

Every Issue has a Pull Request associated that shows which code was written for it.

We have tried to make explicit every decision taken within the issues so a possible way to review the task will be to check in [Closed Issues](https://github.com/jd-erreape/teachers-test-app/issues?q=is%3Aissue+is%3Aclosed) and see why some decisions where made (they are also ordered chronologically).

### Sign up / Sign in

This is stated in a [Github issue](https://github.com/jd-erreape/teachers-test-app/issues/13), however, maybe is worthy to add a paragraph about it. 

In the task description, it was said that Sign up / Sign in was not required, but as it didn't say that it was forbidden, I've preferred to add it specially because of the following reason:

- Use cases about Teachers voting for Teachers or Courses without having a `current_teacher` seemed too strange to me, not sure if the basic requirement was just to have a set of dropdowns where whoever, even if not logged in, could chose a combination of Teacher / Course or Teacher / Teacher to vote but I think this cleans a lot the use cases

## Possible improvements

- Views are maybe not as DRYed as they could be, given the strict time scope we had for the task we didn't put too much effort on them, probably, the Bootstrap components could have been extracted and reused in several places
- Controller specs which were pretty similar have been extracted to shared examples since the beginning, however, there are still some which, in my opinion, with a little bit of effort could also be shared. Anyway our first goal was to achieve 100% coverage and once we have that, we should be confident enough to perform refactors in our app and specs to refine the design