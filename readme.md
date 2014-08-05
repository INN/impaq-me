# Impaq.Me

[![Build Status](https://magnum.travis-ci.com/testdouble/impaq-me.svg?token=zzFpGDKukxjbdxpbyHZY&branch=master)](https://magnum.travis-ci.com/testdouble/impaq-me)

This README discusses how to get up-and-running with the app in development.

## Installing

### Install Postgres

```
brew install postgresql
brew services start postgresql
```

### Install ruby stuff
```
brew install rbenv ruby-build
echo 'eval "$(rbenv init -)"' >> ~/.profile
```

Then run `rbenv install -list | grep 2.0.0` to find the latest Ruby 2.0 patch-level (currently that's "2.0.0-p451")

```
rbenv install 2.0.0-p451
rbenv local 2.0.0-p451
gem install bundler
```

In the repo root, run:

```
bundle
```

Verify things work by running `bundle exec rails c`

### Install node stuff

Install the [latest Node.js](http://nodejs.org)

#### Build the SDK

```
sudo npm i -g lineman
cd sdk
npm install
lineman clean build
```

#### Build the iframe

```
sudo npm i -g lineman
cd iframe
npm install
lineman clean build
```

## Prepare the database

Create the development database, run our migrations, and then seed some development data.

```
bundle exec rake db:create db:migrate db:seed
```

## Start the servers

Simply run this start script to launch Rails, Lineman SDK, and Lineman IFrame in a single process. Use Ctrl-C to shut down all three servers at once.

```
$ ./script/start.dev
```

### Verify the app

Some example routes:

* [Dashboard](http://localhost:3000/dashboard)
* [Sample widget page via SDK](http://localhost:8001/)
* [Banner mode iframe](http://localhost:8000/iframe?mode=banner&article_url=http%3A%2F%2Fvoiceofsandiego.org%2F2014%2F05%2F27%2Fmorning-report-the-lawyer-developers-love-to-hate%2F&article_title=Morning%20Report%3A%20The%20Lawyer%20Developers%20Love%20to%20Hate%20%7C%20Voice%20of%20San%20Diego)
* [Widget mode iframe](http://localhost:8000/iframe?mode=widget&article_url=http%3A%2F%2Fvoiceofsandiego.org%2F2014%2F05%2F27%2Fmorning-report-the-lawyer-developers-love-to-hate%2F&article_title=Morning%20Report%3A%20The%20Lawyer%20Developers%20Love%20to%20Hate%20%7C%20Voice%20of%20San%20Diego)

The two above widgets were snagged from [this production article share](http://voiceofsandiego.org/2014/05/27/morning-report-the-lawyer-developers-love-to-hate/?shared_via_impaq_me=true&utm_campaign=52e91025373635000ffa0200&utm_medium=social&utm_source=impaqme)

## Deploy the app

There's a little included script for deploying to heroku:

## Usage

To deploy an app:

```
$ ./deploy remote-name app-name
```

To deploy an app with migrations:

```
$ ./deploy remote-name app-name true
```

To deploy an app with migrations and enable maintenance mode for the entire duration:

```
$ ./deploy remote-name app-name true true
```

To deploy an app with maintenance mode but no migrations:

```
$ ./deploy remote-name app-name "" true
```

For production, "remote-name" is probably `heroku` and "app-name" is `impaqme`

For staging, "remote-name" is probably `staging` and "app-name" is `impaqme-712`

You can check your remote names with `git remote -v`.
