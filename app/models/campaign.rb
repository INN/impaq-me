require 'dumps_csv'

class Campaign
  class NoGoal < RuntimeError; end

  include Mongoid::Document
  include DumpsCSV

  DEFAULT_WIDGET_HEADER = '<strong>Share</strong> and {{foundation_name}} will donate <strong>${{value_per_share}}</strong>'
  DEFAULT_WIDGET_SOLICIT = '<strong>Share this article</strong> and {{foundation_name}} will donate <strong>${{value_per_share}}</strong> to {{publisher_name}}, a non-profit news organization.'
  DEFAULT_WIDGET_CTA = 'Show you care about public service journalism by donating an additional <strong>${{recommended_donation}}</strong> to {{publisher_name}}.'

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
  field :widget_header, type: String, default: DEFAULT_WIDGET_HEADER
  field :widget_solicit, type: String, default: DEFAULT_WIDGET_SOLICIT
  field :widget_follow_up_cta, type: String, default: DEFAULT_WIDGET_CTA

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
