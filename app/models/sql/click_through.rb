require 'yaml'

module Sql
  class ClickThrough < ActiveRecord::Base
    belongs_to :campaign

    before_create :set_value, :unless => -> { value.present? }

    USER_AGENT_BLACKLIST = Regexp.union(YAML.load_file(Rails.root.join('config/user_agent_blacklist.yml')))

    # TODO - note that Share has the exact same scope.
    def self.past_clicks(share)
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
      self.value = monied_click? ? campaign.value_per_click : 0.0
    end

    def monied_click?
      ClickThrough.past_clicks(self).empty? unless blacklisted_agent?
    end

    def blacklisted_agent?
      user_agent =~ USER_AGENT_BLACKLIST
    end
  end
end
