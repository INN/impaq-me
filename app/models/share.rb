class Share
  include Mongoid::Document

  field :campaign_id
  field :channel
  field :ip
  field :referer
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
end
