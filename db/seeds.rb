# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count == 0
  user = User.new({ 
    name: "Bobby Fancy",
    email: "blah@blah.com",
    password: "lookatme",
    password_confirmation:"lookatme"
  })
  user.save_with_remember_token
end
