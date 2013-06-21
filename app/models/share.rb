require 'dumps_csv'

class Share
  include Mongoid::Document
  include Mongoid::Timestamps

  include DumpsCSV

  field :article_url
  field :channel
  field :ip
  field :referer
  field :value, type: Float, default: 0
  field :created_at
  field :updated_at

  belongs_to :campaign

  before_save :set_value

  def self.past_shares share
    where(article_url: share.article_url).
      and(campaign: share.campaign).
      and(ip: share.ip).
      ne(id: share.id).
      order_by(created_at: :asc)
  end

  def self.for_campaign campaign
    where(campaign: campaign)
  end

  def self.total_for_campaign campaign
    for_campaign(campaign).sum(:value)
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
