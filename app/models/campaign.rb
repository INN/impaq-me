class Campaign
  class NoGoal < RuntimeError; end
  include Mongoid::Document
  field :foundation_name, type: String
  field :publisher_name, type: String
  field :domains, type: Array
  field :value_per_share, type: Float
  field :goal, type: Float

  has_many :shares

  def self.fetch_by_domain domain
    find_by(:domains => domain)
  end

  def self.goal_for(id: id)
      find(id).goal or raise NoGoal
  end
end
