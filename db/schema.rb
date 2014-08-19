# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140818183556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "articles", force: true do |t|
    t.integer  "campaign_id"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["campaign_id"], name: "index_articles_on_campaign_id", using: :btree

  create_table "campaigns", force: true do |t|
    t.string   "mongo_id"
    t.string   "foundation_name"
    t.string   "publisher_name"
    t.text     "domains",                             array: true
    t.float    "value_per_share",     default: 1.0
    t.float    "value_per_click",     default: 1.0
    t.float    "goal"
    t.string   "paypal_email"
    t.string   "twitter_username"
    t.integer  "share_cooldown_days", default: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disabled",            default: false
    t.boolean  "deleted",             default: false
    t.datetime "starts_at"
    t.datetime "ends_at"
  end

  add_index "campaigns", ["mongo_id"], name: "index_campaigns_on_mongo_id", unique: true, using: :btree

  create_table "click_throughs", force: true do |t|
    t.string   "mongo_id"
    t.text     "article_url"
    t.string   "channel"
    t.string   "ip"
    t.text     "referer"
    t.text     "user_agent"
    t.float    "value"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  add_index "click_throughs", ["article_id"], name: "index_click_throughs_on_article_id", using: :btree
  add_index "click_throughs", ["campaign_id"], name: "index_click_throughs_on_campaign_id", using: :btree
  add_index "click_throughs", ["mongo_id"], name: "index_click_throughs_on_mongo_id", unique: true, using: :btree

  create_table "links", force: true do |t|
    t.string   "mongo_id"
    t.text     "long_url"
    t.string   "channel"
    t.string   "slug"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  add_index "links", ["article_id"], name: "index_links_on_article_id", using: :btree
  add_index "links", ["campaign_id"], name: "index_links_on_campaign_id", using: :btree
  add_index "links", ["mongo_id"], name: "index_links_on_mongo_id", unique: true, using: :btree

  create_table "paypal_donations", force: true do |t|
    t.string   "mongo_id"
    t.text     "json_payload"
    t.text     "action"
    t.text     "address_city"
    t.text     "address_country"
    t.text     "address_country_code"
    t.text     "address_name"
    t.text     "address_state"
    t.text     "address_status"
    t.text     "address_street"
    t.text     "address_zip"
    t.text     "article_url"
    t.text     "business"
    t.text     "charset"
    t.text     "controller"
    t.text     "custom"
    t.text     "first_name"
    t.text     "handling_amount"
    t.text     "ipn_track_id"
    t.text     "item_name"
    t.text     "item_number"
    t.text     "last_name"
    t.text     "mc_currency"
    t.float    "mc_fee",                 default: 0.0
    t.float    "mc_gross",               default: 0.0
    t.text     "notify_version"
    t.text     "option_name1"
    t.text     "option_selection1"
    t.text     "option_name2"
    t.text     "option_selection2"
    t.text     "option_name3"
    t.text     "option_selection3"
    t.text     "payer_email"
    t.text     "payer_id"
    t.text     "payer_status"
    t.text     "payment_date"
    t.float    "payment_fee",            default: 0.0
    t.float    "payment_gross",          default: 0.0
    t.text     "payment_status"
    t.text     "payment_type"
    t.text     "protection_eligibility"
    t.float    "quantity",               default: 0.0
    t.text     "receipt_id"
    t.text     "receiver_email"
    t.text     "receiver_id"
    t.text     "resend"
    t.text     "residence_country"
    t.text     "shipping"
    t.float    "tax",                    default: 0.0
    t.text     "test_ipn"
    t.text     "transaction_subject"
    t.text     "txn_id"
    t.text     "txn_type"
    t.text     "user_address"
    t.text     "verify_sign"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paypal_donations", ["campaign_id"], name: "index_paypal_donations_on_campaign_id", using: :btree
  add_index "paypal_donations", ["mongo_id"], name: "index_paypal_donations_on_mongo_id", unique: true, using: :btree

  create_table "shares", force: true do |t|
    t.string   "mongo_id"
    t.text     "article_url"
    t.string   "channel"
    t.string   "ip"
    t.text     "referer"
    t.float    "value"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  add_index "shares", ["article_id"], name: "index_shares_on_article_id", using: :btree
  add_index "shares", ["campaign_id"], name: "index_shares_on_campaign_id", using: :btree
  add_index "shares", ["mongo_id"], name: "index_shares_on_mongo_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "mongo_id"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variants", force: true do |t|
    t.string   "mongo_id"
    t.float    "recommended_donation", default: 1.0
    t.text     "widget_header"
    t.text     "widget_solicit"
    t.text     "widget_follow_up_cta"
    t.text     "widget_thanks"
    t.text     "banner_thanks"
    t.text     "email_body"
    t.text     "css_overrides"
    t.float    "shown_amount",         default: 100.0
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variants", ["campaign_id"], name: "index_variants_on_campaign_id", using: :btree
  add_index "variants", ["mongo_id"], name: "index_variants_on_mongo_id", unique: true, using: :btree

end
