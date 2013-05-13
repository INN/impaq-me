class Iframe
  def self.bootstrap publisher, article_url
    campaign = publisher.campaign
    campaign_meter = CampaignMeter.for campaign
    shortlink = Shortlink.for_campaign_and_url campaign.id, article_url #TODO needs to work via pub

    {
      article_url: article_url,
      domain: "depricated.com",
      foundation_name: campaign.foundation_name,
      publisher_name: publisher.name,
      paypal_link: publisher.paypal_link,
      value_per_share: campaign.value_per_share.to_i
    }.merge(campaign_meter).merge(shortlink)
  end
end
