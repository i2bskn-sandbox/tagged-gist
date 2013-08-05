Tagged Gist
===========

[![Build Status](https://travis-ci.org/i2bskn/tagged-gist.png?branch=master)](https://travis-ci.org/i2bskn/tagged-gist)
[![Coverage Status](https://coveralls.io/repos/i2bskn/tagged-gist/badge.png)](https://coveralls.io/r/i2bskn/tagged-gist)
[![Code Climate](https://codeclimate.com/github/i2bskn/tagged-gist.png)](https://codeclimate.com/github/i2bskn/tagged-gist)
[![Dependency Status](https://gemnasium.com/i2bskn/tagged-gist.png)](https://gemnasium.com/i2bskn/tagged-gist)


Web application to tag the Gists.

#### Application on Heroku

[https://tagged-gist.herokuapp.com](https://tagged-gist.herokuapp.com)

## Requirements

* Ruby 2.0.0
* PostgreSQL

## Configuration

#### Sessions secret key

```
export RAILS_SECRET_KEY=rails_secret_key_base
```

#### GitHub Application Key

```
export GITHUB_KEY=your_app_client_id
export GITHUB_SECRET=your_app_client_secret
```

#### Database Settings

Only development/test environments.

```
export RAILS_DB_USER=user_name
export RAILS_DB_PASSWORD=password
export RAILS_DB_HOST=localhost
export RAILS_DB_PORT=5432
```

## Deproyment instructions

#### for Heroku

```
heroku create
heroku config:set RAILS_SECRET_KEY=rails_secret_key_base
heroku config:set GITHUB_KEY=your_app_client_id
heroku config:set GITHUB_SECRET=your_app_client_secret
heroku config:set BUNDLE_WITHOUT="development:test"
git push heroku master
heroku open
```
