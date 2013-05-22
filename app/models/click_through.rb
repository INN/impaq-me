class ClickThrough
  include Mongoid::Document

  field :ip
  field :channel
  field :long_url
  field :referer
  field :value, type: Integer, default: 0
  field :timestamp, default: DateTime.now

  belongs_to :campaign
  belongs_to :link

  before_save :set_value

  def self.total_for_campaign campaign_id
    where(campaign_id: campaign_id).map(&:value).sum
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << fields_to_a
      each do |click|
        csv << click.attributes.values_at(*fields_to_a)
      end
    end
  end

  def self.fields_to_a
    self.fields.map { |field| field[0] }
  end

  def set_value
    value_per_click = Campaign.find(campaign_id).value_per_click
    self.value = value_per_click if new_clicker?
  end

  private

  def new_clicker?
    ClickThrough.where(ip: ip).and(link_id: link_id).ne(id: id).count == 0
  end
end
