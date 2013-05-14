require 'addressable/uri'

class Iframe
  def self.bootstrap article
    article_url = Addressable::URI.heuristic_parse(article.url).normalize
    campaign = Campaign.find_by domains: article_url.host
    campaign_meter = CampaignMeter.for campaign
    shortlink = Shortlink.for_campaign_and_url campaign.id, article_url.to_s

    {
      article_url: article_url.to_s,
      article_title: article.title,
      domain: article_url.host,
      foundation_name: campaign.foundation_name,
      publisher_name: campaign.publisher_name,
      value_per_share: campaign.value_per_share.to_i,
      paypal: campaign.paypal,
    }.merge(campaign_meter).merge(shortlink)
  end

end
