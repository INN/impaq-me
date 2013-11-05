require 'dumps_csv'

class Campaign
  class NoGoal < RuntimeError; end

  include Mongoid::Document
  include DumpsCSV

  DEFAULT_WIDGET_HEADER = '<strong>Share</strong> and {{foundation_name}} will donate <strong>${{value_per_share}}</strong>'

  field :foundation_name, type: String
  field :publisher_name, type: String
  field :domains, type: Array
  field :value_per_share, type: Float, default: 1.0
  field :value_per_click, type: Float, default: 1.0
  field :goal, type: Float
  field :paypal_email, type: String
  field :twitter_username, type: String
  field :recommended_donation, type: Float, default: 1.0
  field :share_cooldown_days, type: Integer, default: 30
  field :widget_header, type: String

  has_many :shares
  has_many :links
  has_many :click_throughs

  def self.goal id
    find(id).goal or raise NoGoal
  end

  def domains_to_s
    domains.join ', ' if domains
  end
end
