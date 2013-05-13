class Link
  include Mongoid::Document

  field :campaign_id
  field :long_url
  field :channel
  field :clicks, type: Integer, default: 0
  field :referer

  belongs_to :campaign
  has_many :click_throughs

  alias :slug :id

  def create_click_through ip, referer
    click_throughs.create(ip: ip, channel: channel, long_url: long_url, campaign_id: campaign.id, referer: referer)
  end
end
