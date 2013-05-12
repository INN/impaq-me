class Iframe
  def self.bootstrap article_url
    domain = URL.new(article_url).domain
    campaign = Campaign.find_by domains: domain
    campaign_meter = CampaignMeter.for campaign
    shortlink = Shortlink.for_campaign_and_url campaign.id, article_url

    {
      article_url: article_url,
      domain: domain,
      foundation_name: campaign.foundation_name,
      publisher_name: campaign.publisher_name,
      value_per_share: campaign.value_per_share.to_i
    }.merge(campaign_meter).merge(shortlink)
  end
end
