require 'yaml'
require 'dumps_csv'

module Mongo
  class ClickThrough
    include Mongoid::Document
    store_in collection: "click_throughs"
    include Mongoid::Timestamps

    include DumpsCSV

    field :article_url
    field :channel
    field :ip
    field :referer
    field :user_agent
    field :value, type: Float, default: 0
    field :created_at
    field :updated_at

    belongs_to :campaign, index: true
    before_save :set_value

    USER_AGENT_BLACKLIST = Regexp.union YAML.load_file Rails.root.join 'config/user_agent_blacklist.yml'

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

    private

    def set_value
      self.value = campaign.value_per_click if monied_click?
    end

    def monied_click?
      ClickThrough.past_clicks(self).empty? unless blacklisted_agent?
    end

    def blacklisted_agent?
      user_agent =~ USER_AGENT_BLACKLIST
    end
  end
end
