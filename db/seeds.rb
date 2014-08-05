def seed_users!
  return if User.count > 0
  User.create!({
    name: "John Doe",
    email: "user@example.com",
    password: "password",
    password_confirmation:"password"
  })
  puts <<-TEXT
    Created User
    =============
    Email:    user@example.com
    Password: password
  TEXT
end

def seed_campaigns!
  return if Campaign.count > 0

  Campaign.create!(
    :foundation_name => "Foundation A",
    :publisher_name => "Publisher A",
    :domains => ["localhost", "demo.testdouble.com"],
    :goal => 2500.0,
    :paypal_email => "user@example.com",
    :twitter_username => "testdouble",
    :variants => [
      Variant.new(
        :recommended_donation => 1.0,
        :css_overrides => "",
        :shown_amount => 100.0
      )
    ]
  ).tap { |campaign| puts_model(campaign) }

  Campaign.create!(
    :foundation_name => "Foundation B (2 Variants)",
    :publisher_name => "Publisher B",
    :domains => ["127.0.0.1"],
    :value_per_share => 2.0,
    :value_per_click => 1.0,
    :goal => 2500.0,
    :paypal_email => "user@example.com",
    :twitter_username => "inn",
    :variants => [
      Variant.new(
        :recommended_donation => 1.0,
        :css_overrides => "",
        :shown_amount => 70.0
      ),
      Variant.new(
        :recommended_donation => 1.0,
        :css_overrides => "",
        :shown_amount => 30.0
      )
    ]
  ).tap { |campaign| puts_model(campaign) }
end

def puts_model(model)
  puts <<-TEXT
    Created #{model.class.name}
    ===========================
    #{model.attributes.map { |key, value| "      #{key.humanize}: #{value}" }.join("\n")}
  TEXT
end

unless Rails.env.production?
  seed_users!
  seed_campaigns!
end
