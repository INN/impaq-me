class Link
  include Mongoid::Document

  field :campaign_id
  # field :slug
  field :long_url
  field :channel
  field :shares, type: Integer, default: 0
  field :clicks, type: Integer, default: 0

  belongs_to :campaign

end
