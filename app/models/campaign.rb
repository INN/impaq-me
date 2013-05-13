class Campaign
  class NoGoal < RuntimeError; end
  include Mongoid::Document
  field :name, type: String
  field :foundation_name, type: String
  field :value_per_share, type: Float, default: 1.0
  field :value_per_click, type: Float, default: 1.0
  field :goal, type: Float
  field :about_uri, type: String

  has_many :shares
  has_many :links
  has_many :click_throughs
  has_many :publishers

  def self.goal id
      find(id).goal or raise NoGoal
  end

  def domains_to_s
    domains.join ', ' if domains
  end
end
