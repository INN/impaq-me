class Link
  include Mongoid::Document

  field :campaign_id
  field :long_url
  field :channel
  field :clicks, type: Integer, default: 0
  field :referer
  field :slug

  belongs_to :campaign
  has_many :click_throughs

  before_save { self.slug = generate_slug }

  def generate_slug
   id.to_s[0..9]
  end

  def create_click_through ip, referer
    click_throughs.create(ip: ip, channel: channel, long_url: long_url, campaign_id: campaign.id, referer: referer)
  end
end
