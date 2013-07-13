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

#### GitHub Application config

```
export GITHUB_KEY=your_app_client_id
export GITHUB_SECRET=your_app_client_secret
```

## Deproyment instructions

#### for Heroku

```
heroku create
heroku config:set RAILS_SECRET_KEY=rails_secret_key_base
heroku config:set GITHUB_KEY=your_app_client_id
heroku config:set GITHUB_SECRET=your_app_client_secret
git push heroku master
heroku open
```
