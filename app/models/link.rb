class Link
  include Mongoid::Document

  field :campaign_id
  field :long_url
  field :channel
  field :clicks, type: Integer, default: 0

  belongs_to :campaign

  alias :slug :id

end
