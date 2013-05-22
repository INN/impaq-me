class Share
  include Mongoid::Document
  include Mongoid::Timestamps

  field :campaign_id
  field :channel
  field :ip
  field :referer
  field :value, type: Float, default: 0

  validates :campaign_id, presence: true
  validates :channel, presence: true
  validates :ip, presence: true

  belongs_to :campaign

  before_save :set_value

  scope :past_shares, ->(share) { where(campaign_id: share.campaign.id).and(ip: share.ip).ne(id: share.id).order_by(created_at: :asc) }

  def self.total_for_campaign(campaign_id)
    where(campaign_id: campaign_id).map(&:value).sum
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << fields_to_a
      each do |share|
        csv << share.attributes.values_at(*fields_to_a)
      end
    end
  end

  def self.fields_to_a
    self.fields.map { |field| field[0] }
  end

  private

  def set_value
    self.value = campaign.value_per_share if monied_share?
  end

  def monied_share?
    return true if Share.past_shares(self).empty?

    days_since_shared = (Time.now - Share.past_shares(self).last.created_at) / 60
    days_since_shared > campaign.share_cooldown_days
  end
end
