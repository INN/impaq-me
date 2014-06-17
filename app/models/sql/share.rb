module Sql
  class Share < ActiveRecord::Base
    belongs_to :campaign

    before_create :set_value, :unless => -> { value.present? }

    def self.past_shares(share)
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
      return true if Share.past_shares(self).empty?

      days_since_shared = (Time.now - Share.past_shares(self).last.created_at) / 60
      days_since_shared > campaign.share_cooldown_days
    end
  end
end
