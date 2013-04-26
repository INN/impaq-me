class Campaign
  include Mongoid::Document
  field :foundation_name, type: String
  field :publisher_name, type: String
  field :domains, type: Array
  field :value_per_share, type: BigDecimal

  has_many :shares

  def self.fetch_by_domain domain
    find_by(:domains => domain)
  end
end
