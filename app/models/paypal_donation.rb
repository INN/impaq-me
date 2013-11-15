require 'dumps_csv'

class PaypalDonation
  include Mongoid::Document
  include DumpsCSV

  field :action
  field :address_city
  field :address_country
  field :address_country_code
  field :address_name
  field :address_state
  field :address_status
  field :address_street
  field :address_zip
  field :article_url
  field :business
  field :charset
  field :controller
  field :custom
  field :first_name
  field :ipn_track_id
  field :item_name
  field :item_number
  field :last_name
  field :mc_currency
  field :mc_fee                , type: Float, default: 0
  field :mc_gross              , type: Float, default: 0
  field :notify_version
  field :option_name1
  field :option_selection1 # campaign_id
  field :option_name2
  field :option_selection2 # article_url
  field :option_name3
  field :option_selection3 # user_address
  field :payer_email
  field :payer_id
  field :payer_status
  field :payment_date
  field :payment_fee           , type: Float, default: 0
  field :payment_gross         , type: Float, default: 0
  field :payment_status
  field :payment_type
  field :protection_eligibility
  field :quantity              , type: Float, default: 0
  field :receiver_email
  field :receiver_id
  field :residence_country
  field :tax                   , type: Float, default: 0
  field :test_ipn
  field :transaction_subject
  field :txn_id
  field :txn_type
  field :user_address
  field :verify_sign

  # must be explicit about campaign_id as a field
  field :campaign_id           , type: Moped::BSON::ObjectId
  belongs_to :campaign

  def self.for_campaign campaign
    where(campaign: campaign)
  end

  def self.total_for_campaign campaign
    for_campaign(campaign).sum(:mc_gross)
  end
end
