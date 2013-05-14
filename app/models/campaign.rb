class Campaign
  class NoGoal < RuntimeError; end
  include Mongoid::Document
  field :foundation_name, type: String
  field :publisher_name, type: String
  field :domains, type: Array
  field :value_per_share, type: Float, default: 1.0
  field :value_per_click, type: Float, default: 1.0
  field :goal, type: Float
  field :paypal, type: String

  has_many :shares
  has_many :links
  has_many :click_throughs
  has_many :publishers

  def self.goal id
      find(id).goal or raise NoGoal
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << fields_to_a
      each do |campaign|
        csv << campaign.attributes.values_at(*fields_to_a)
      end
    end
  end

  def self.fields_to_a
    self.fields.map { |field| field[0] }
  end

  def domains_to_s
    domains.join ', ' if domains
  end
end
