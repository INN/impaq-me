require 'addressable/uri'

class Iframe
  def self.bootstrap article
    article_url = Addressable::URI.heuristic_parse(article.url).normalize
    campaign = Campaign.find_by domains: article_url.host
    campaign_meter = CampaignMeter.for campaign
    shortlink = Shortlink.for_campaign_and_url campaign, article_url.to_s

    {
      campaign_id: campaign.id.to_s,
      article_url: article_url.to_s,
      article_domain: article_url.authority,
      article_title: article.title,
      domain: article_url.host,
      foundation_name: campaign.foundation_name,
      publisher_name: campaign.publisher_name,
      value_per_share: format_dollar(campaign.value_per_share),
      value_per_click: format_dollar(campaign.value_per_click),
      paypal: campaign.paypal,
      recommended_donation: format_dollar(campaign.recommended_donation),
      goal: format_dollar(campaign_meter.goal),
      total: format_dollar(campaign_meter.total),
      percent: campaign_meter.percent,
    }.merge(shortlink)
  end

  def self.format_dollar x
    if x % 1 == 0
      x.to_i
    else
      x.round 2
    end
  end

end
