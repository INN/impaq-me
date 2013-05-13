class Share
  include Mongoid::Document

  field :campaign_id
  field :channel
  field :ip
  field :long_url
  field :timestamp, default: DateTime.now

  validates :campaign_id, presence: true
  validates :channel, presence: true
  validates :ip, presence: true

  belongs_to :campaign

  def self.total_for_campaign(campaign_id)
    where(campaign_id: campaign_id).distinct(:ip).count
  end
end
