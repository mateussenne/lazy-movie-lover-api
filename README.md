# Lazy Movie Lover

The objective os this project is to list (and only list) movies from different streaming platforms so it's easier to find where to watch it.

# Scraping

The `NetflixSpider` is the only one working at the moment, and at a limited capacity. Some of the info we're showing on the API are:

- Movie Url
- Stream service code
- Poster image

# Up and running

Run the bundler:
`bundle install`

Execute pending migrations and run rails:

```
rails db:create
rails db:migrate
rails db:seed
rails s
```

To create the movie database, run sidekiq and wait for the scrape to finish
`bundle exec sidekiq`

# User control and profile

The API have a basic registration / authentication for testing purposes. The ideia is to implement an user "club" where profiles can favorite and share their preferred movies with friends.

Register an user at `POST /api/users`

```JSON
  {
    "user": {
    "name": "Jhon Doe",
    "email": "jhondoe@email.com",
    "username": "JhonDoe",
    "age": 31
    }
  }
```

Login at `POST /api/users/login`

```JSON
{
  "email": "jhondoe@email.com",
  "password": "strongpassword123"
}
```

Retrieve the generated token a pass it as bearer auth when sending other requests.

List all movies: `GET /api/movies?page=:page_number&search=:movie_title`

Set a movie as favorite `POST /api/movies/favorite/:movie_id`

Check your profile: `GET /api/profile`
