require 'dumps_csv'
require 'cleans_urls'

class Share < ActiveRecord::Base
  include DumpsCsv
  belongs_to :campaign
  belongs_to :article

  before_create :set_value, :unless => -> { value.present? }

  def self.create_from_params!(params)
    url = CleansUrls.new(params[:article_url]).to_s
    Share.create!(params.merge(
      :article_url => url,
      :article => Article.for(params[:campaign_id], url)
    ))
  end

  def self.past_dupes(share)
    where(
      :article_url => share.article_url,
      :campaign_id => share.campaign_id,
      :ip => share.ip
    ).where.not(
      :id => share.id
    ).order(:created_at)
  end

  def self.for_campaign(campaign)
    where(campaign: campaign)
  end

  def self.total_for_campaign(campaign)
    for_campaign(campaign).sum(:value)
  end

private

  def set_value
    self.value = monied_share? ? campaign.value_per_share : 0.0
  end

  def monied_share?
    return false if campaign.met_goal?
    return true unless last_share = Share.past_dupes(self).last
    Time.zone.now - last_share.created_at > campaign.share_cooldown_days.days
  end
end
