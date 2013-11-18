require 'dumps_csv'

class Campaign
  class NoGoal < RuntimeError; end

  include Mongoid::Document
  include DumpsCSV

  field :foundation_name      , type: String
  field :publisher_name       , type: String
  field :domains              , type: Array
  field :value_per_share      , type: Float   , default: 1.0
  field :value_per_click      , type: Float   , default: 1.0
  field :goal                 , type: Float
  field :paypal_email         , type: String
  field :twitter_username     , type: String
  field :share_cooldown_days  , type: Integer , default: 30

  FIELDS_TO_EXCLUDE_FROM_CSV = ['widget_header', 'widget_solicit', 'widget_follow_up_cta',
                                'widget_thanks', 'banner_thanks', 'email_body']

  has_many :shares
  has_many :links
  has_many :click_throughs
  has_many :paypal_donations

  has_many :variants
  accepts_nested_attributes_for :variants

#   validates :variants, :length => { :minimum => 1 }

  def initialize
    super
    variants.build
  end

  def self.goal id
    find(id).goal or raise NoGoal
  end

  def domains_to_s
    domains.join ', ' if domains
  end
end
