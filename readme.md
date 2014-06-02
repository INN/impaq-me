# Impaq.Me

## get up and running

### Install Mongo DB 2.4:

```
cd $( brew --prefix )
git checkout 10e8328 Library/Formula/mongodb.rb
brew install mongodb
brew services start mongo
git checkout Library/Formula/mongodb.rb
```

Fetch the latest Mongo dump from production to seed your development:

```
mongodump -h zach.mongohq.com:10015 -d app15233185 -u heroku -p 22daece1d5c89bf50cf7ac6f172a35f7 -o prod.mongo
mongorestore prod.mongo
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

```
sudo npm i -g lineman
cd sdk
npm install
```

Run a `lineman clean build` to verify things are working.

## Run the app

### Create an account

Create a development account for yourself:

```
$ bundle exec rails c
  MOPED: 127.0.0.1:27017 COMMAND      database=admin command={:ismaster=>1} runtime: 9.6950ms
Loading development environment (Rails 4.0.3)
irb(main):001:0> User.create!(name: "foo", email: "foo@foo.com", password: "foo", password_confirmation: "foo")
  MOPED: 127.0.0.1:27017 INSERT       database=app15233185 collection=users documents=[{"_id"=>BSON::ObjectId('538cea00736561ee34000000'), "name"=>"foo", "email"=>"foo@foo.com", "password_digest"=>"$2a$10$CjQBUQyta8dR.YWfyQzX1uFmc9XzZ/BmMjGChfpil59cJvVK7RyDW", "remember_token"=>"J0xDXxnf4LIe2lceiphx3Q"}] flags=[]
                         COMMAND      database=app15233185 command={:getlasterror=>1, :w=>1} runtime: 31.3270ms
=> #<User _id: 538cea00736561ee34000000, name: "foo", email: "foo@foo.com", password_digest: "$2a$10$CjQBUQyta8dR.YWfyQzX1uFmc9XzZ/BmMjGChfpil59cJvVK7RyDW", remember_token: "J0xDXxnf4LIe2lceiphx3Q">
irb(main):002:0>
```

### Verify the app

Get the backend up and running

```
$ bundle exec rails s
```

Some example routes:

* [Dashboard](http://localhost:3000/dashboard)
* [Banner mode iframe](http://localhost:3000/iframe?mode=banner&article_url=http%3A%2F%2Fvoiceofsandiego.org%2F2014%2F05%2F27%2Fmorning-report-the-lawyer-developers-love-to-hate%2F&article_title=Morning%20Report%3A%20The%20Lawyer%20Developers%20Love%20to%20Hate%20%7C%20Voice%20of%20San%20Diego)
* [Widget mode iframe](http://localhost:3000/iframe?mode=widget&article_url=http%3A%2F%2Fvoiceofsandiego.org%2F2014%2F05%2F27%2Fmorning-report-the-lawyer-developers-love-to-hate%2F&article_title=Morning%20Report%3A%20The%20Lawyer%20Developers%20Love%20to%20Hate%20%7C%20Voice%20of%20San%20Diego)
