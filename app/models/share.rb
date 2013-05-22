class Share
  include Mongoid::Document

  field :campaign_id
  field :channel
  field :ip
  field :referer
  field :value
  field :timestamp, default: DateTime.now

  validates :campaign_id, presence: true
  validates :channel, presence: true
  validates :ip, presence: true

  belongs_to :campaign

  def self.total_for_campaign(campaign_id)
    where(campaign_id: campaign_id).distinct(:ip).count
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

  def set_value
    value = Campaign.find(campaign_id).value_per_share if value_share?
  end

  private
  def value_share?
    past_shares = Share.where(campaign_id: campaign_id).and(ip: ip)
    if past_shares.count == 0
      true
    else
      off_cooldown? past_shares
    end
  end

  def off_cooldown? past_shares
    last_shared_on = past_shares.map(&:timestamp).max
    days_since_shared = (Time.now - last_shared_on) / 60
    days_since_shared > Campaign.find(campaign_id).share_cooldown_days
  end
end
