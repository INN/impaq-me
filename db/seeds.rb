if User.count == 0
  user = User.new({ 
    name: "Bobby Fancy",
    email: "blah@blah.com",
    password: "lookatme",
    password_confirmation:"lookatme"
  })
  user.save!
end
