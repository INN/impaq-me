class Campaign
  class NoGoal < RuntimeError; end
  include Mongoid::Document
  field :foundation_name, type: String
  field :publisher_name, type: String
  field :domains, type: Array
  field :value_per_share, type: Float, default: 1.0
  field :goal, type: Float

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
