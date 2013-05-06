class Link
  include Mongoid::Document

  field :campaign_id
  # field :slug
  field :long_url
  field :channel
  field :clicks, type: Integer, default: 0

  belongs_to :campaign

end
