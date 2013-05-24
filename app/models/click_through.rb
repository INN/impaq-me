class ClickThrough
  include Mongoid::Document
  include Mongoid::Timestamps

  field :article_url
  field :channel
  field :ip
  field :referer
  field :user_agent
  field :value, type: Float, default: 0
  field :created_at
  field :updated_at

  belongs_to :campaign
  before_save :set_value

  AGENT_BLACKLIST = /Twitterbot|facebookexternalhit/

  def self.past_clicks click
    where(article_url: click.article_url).
      and(campaign: click.campaign).
      and(ip: click.ip).
      ne(id: click.id).
      order_by(created_at: :asc)
  end

  def self.for_campaign campaign
    where(campaign: campaign)
  end

  def self.total_for_campaign campaign
    for_campaign(campaign).sum(:value)
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

  private

  def set_value
    self.value = campaign.value_per_click if monied_click?
  end

  def monied_click?
    ClickThrough.past_clicks(self).empty? unless blacklisted_agent?
  end

  def blacklisted_agent?
    user_agent =~ AGENT_BLACKLIST
  end
end
