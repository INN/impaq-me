class Share
  include Mongoid::Document

  field :campaign_id
  field :channel
  field :ip

  validates :campaign_id, presence: true
  validates :channel, presence: true
  validates :ip, presence: true

  belongs_to :campaign

  def self.total_for(campaign_id: campaign_id)
    where(campaign_id: campaign_id).count
  end

end
