# Fast & Furious Cinema API

API for cinema that plays only Fast & Furious movies (for some reason).
## Requirements

- Ruby 2.7.2
- Rails 6.1.3
- PostgreSQL 11 or higher

## Setup

1. Install all needed gems

```
bundle exec bundle install
```

2. Setup the database

```
bundle exec rake db:setup
```

3. Run the local server environment

```
bundle exec rails s
```

The app should be responding on `localhost:3000`

## Testing

To run all test suites run

```
bundle exec rspec
```

## Swagger documentation

The Swagger 2.0 compliant documentation is available on `localhost:3000/swagger`

## Decision log

- JWT tokens were selected as the authentication method as it's pretty easy to maintain and right now there is no need to introduce something more complex like e.g. OAuth2 (it could make sense if there would be some 3rd party systems that would need to integrate with this API). It was also pretty fast to introduce and implement in a Rails-based env.

- `grape` was selected as the library to implement the API as it provides an easy way to organize the API endpoint in separate modules. It also provides a very easy way to produce a Swagger docs and UI (with usage or `grape-swagger` and `grape-swagger-rails` gems).

- `pundit` was selected as the library to manage user permissions as it allows to define separate policies per endpoint. In the current state of the project it may be not so beneficial but at the late stages when the policies gets more and more complicated, such possibility to have separate policies per endpoint is very useful.

- `jsonapi-serializer` was selected as the library to serialize the output to JSON as it provides the compliancy with JSON API standard out of the box.

- There is no validation in models as I wanted to separate the core business logic of models from validations. Separate validators were introduced using `dry-validation` gem as it provides a very clean way to define data contracts.

- Because of no validations in models, I didn't find the need to use `factory-bot`-like gem in specs. Any record that needs to be created in specs is created by a regular call to the model class.

- A very simple roles model was introduces (handled by a single boolean flag) as currently there is basically only one role (cinema worker). The roles model is hidden behind a `User#role?` method so as long as there won't be any other calls to check if user has given role, it should be pretty straightforward to introduce some more complex roles system.

- The calls to OMDb API are handled while creating a movie and needed data from that API call are stored with the movie (including the status of the last OMDb call and potential error message). This way, we need a lot less calls than in a case when we e.g. need to make the API call per each use request for movie data. Also, the API call is made in the background job to not enforce the cinema worker to wait for the response from external API while creating a new movie.

- The movie rating is calculated as the average of user rates. Each rate is stored as a separate record. Each record storage updates the sum of rates and the count of rates for given movie. Then, the movie rating is calculated when the user request for the movie details. Such solution should work at the begging with lower traffic.

- Each movie show time is stored as a separate record. It makes the validation easier (to check that the show times are not colliding). It should be also more useful when e.g. a booking system will be introduced.

## Potential improvements (random ordering)

- Use some else background job handler than `active_job` (e.g. `sidekiq`).

- Introduce Content Security Policy (CSP).

- Introduce a proper roles system (e.g. `rolify`-like with separate table for roles list and a join table between user and role so that user may have many roles and the roles system is separated from the actual user logic).

- Introduce possibility to add show times as recurring events (the cinema worker pass only the start and end dates with showing hour and the backend is creating the show time records based on such template).

- Improve the way of the average movie rating calculation. Maybe the ratings should be re-calculated regularly by some background job. Maybe the average rating-related fields should be moved to a separate model at least (so the whole movie record is not locked while updating its rating).

- Add missing endpoints to e.g. fetch list of all movies, remove rating, etc.
