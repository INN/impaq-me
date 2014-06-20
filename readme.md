# Impaq.Me

## get up and running

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
```

Run a `lineman clean build` to verify things are working.

#### Build the iframe

```
sudo npm i -g lineman
cd iframe
npm install
```

Run a `lineman clean build` to verify things are working.

## Run the app

First, run the migrations:

```
bundle exec rake db:create db:migrate
```

**TODO: add a seeds mechanism so things work out of the box**


### Create an account

Create a development account for yourself:

```
$ bundle exec rails c
Loading development environment (Rails 4.0.3)
irb(main):001:0> User.create!(name: "foo", email: "foo@foo.com", password: "foo", password_confirmation: "foo")
=> #<User id: 1, name: "foo", email: "foo@foo.com", password_digest: "$2a$10$CjQBUQyta8dR.YWfyQzX1uFmc9XzZ/BmMjGChfpil59cJvVK7RyDW", remember_token: "J0xDXxnf4LIe2lceiphx3Q">
irb(main):002:0>
```

Get the Rails backend up and running

```
$ bundle exec rails s
```

In another shell, start the SDK project:

```
$ cd sdk
$ lineman clean run
```

In a third shell, start the iframe project:

```
$ cd iframe
$ lineman clean run
```

### Verify the app

Some example routes:

* [Dashboard](http://localhost:3000/dashboard)
* [Sample widget page via SDK](http://localhost:8001/)
* [Banner mode iframe](http://localhost:8000/iframe?mode=banner&article_url=http%3A%2F%2Fvoiceofsandiego.org%2F2014%2F05%2F27%2Fmorning-report-the-lawyer-developers-love-to-hate%2F&article_title=Morning%20Report%3A%20The%20Lawyer%20Developers%20Love%20to%20Hate%20%7C%20Voice%20of%20San%20Diego)
* [Widget mode iframe](http://localhost:8000/iframe?mode=widget&article_url=http%3A%2F%2Fvoiceofsandiego.org%2F2014%2F05%2F27%2Fmorning-report-the-lawyer-developers-love-to-hate%2F&article_title=Morning%20Report%3A%20The%20Lawyer%20Developers%20Love%20to%20Hate%20%7C%20Voice%20of%20San%20Diego)

The two above widgets were snagged from [this production article share](http://voiceofsandiego.org/2014/05/27/morning-report-the-lawyer-developers-love-to-hate/?shared_via_impaq_me=true&utm_campaign=52e91025373635000ffa0200&utm_medium=social&utm_source=impaqme)
