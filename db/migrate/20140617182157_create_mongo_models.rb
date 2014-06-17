class CreateMongoModels < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :mongo_id
      t.string :foundation_name
      t.string :publisher_name
      t.text :domains, :array => true
      t.float :value_per_share, :default => 1.0
      t.float :value_per_click, :default => 1.0
      t.float :goal
      t.string :paypal_email
      t.string :twitter_username
      t.integer :share_cooldown_days, :default =>30
      t.timestamps
    end
    create_table :links do |t|
      t.string :mongo_id
      t.text :long_url
      t.string :channel
      t.string :slug
      t.references :campaign
      t.timestamps
    end
    create_table :shares do |t|
      t.string :mongo_id
      t.text :article_url
      t.string :channel
      t.string :ip
      t.text :referer
      t.float :value
      t.references :campaign
      t.timestamps
    end
    create_table :click_throughs do |t|
      t.string :mongo_id
      t.text :article_url
      t.string :channel
      t.string :ip
      t.text :referer
      t.text :user_agent
      t.float :value
      t.references :campaign
      t.timestamps
    end
    create_table :paypal_donations do |t|
      t.string :mongo_id

      t.text :json_payload
      t.text :action
      t.text :address_city
      t.text :address_country
      t.text :address_country_code
      t.text :address_name
      t.text :address_state
      t.text :address_status
      t.text :address_street
      t.text :address_zip
      t.text :article_url
      t.text :business
      t.text :charset
      t.text :controller
      t.text :custom
      t.text :first_name
      t.text :handling_amount
      t.text :ipn_track_id
      t.text :item_name
      t.text :item_number
      t.text :last_name
      t.text :mc_currency
      t.float :mc_fee, :default => 0
      t.float :mc_gross, :default => 0
      t.text :notify_version
      t.text :option_name1
      t.text :option_selection1 # campaign_id
      t.text :option_name2
      t.text :option_selection2 # article_url
      t.text :option_name3
      t.text :option_selection3 # user_address
      t.text :payer_email
      t.text :payer_id
      t.text :payer_status
      t.text :payment_date
      t.float :payment_fee, :default => 0
      t.float :payment_gross, :default => 0
      t.text :payment_status
      t.text :payment_type
      t.text :protection_eligibility
      t.float :quantity, :default => 0
      t.text :receipt_id
      t.text :receiver_email
      t.text :receiver_id
      t.text :resend
      t.text :residence_country
      t.text :shipping
      t.float :tax, :default => 0
      t.text :test_ipn
      t.text :transaction_subject
      t.text :txn_id
      t.text :txn_type
      t.text :user_address
      t.text :verify_sign

      t.references :campaign
      t.timestamps
    end
    create_table :variants do |t|
      t.string :mongo_id

      t.float :recommended_donation, :default => 1.0
      t.text :widget_header
      t.text :widget_solicit
      t.text :widget_follow_up_cta
      t.text :widget_thanks
      t.text :banner_thanks
      t.text :email_body
      t.text :css_overrides
      t.float :shown_amount, :default => 100.0

      t.references :campaign
      t.timestamps
    end
    create_table :users do |t|
      t.string :mongo_id

      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end

    add_index :campaigns, :mongo_id, :unique => true
    add_index :links, :campaign_id
    add_index :links, :mongo_id, :unique => true
    add_index :shares, :campaign_id
    add_index :shares, :mongo_id, :unique => true
    add_index :click_throughs, :campaign_id
    add_index :click_throughs, :mongo_id, :unique => true
    add_index :paypal_donations, :campaign_id
    add_index :paypal_donations, :mongo_id, :unique => true
    add_index :variants, :campaign_id
    add_index :variants, :mongo_id, :unique => true
  end
end
