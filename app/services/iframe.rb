class Iframe
  def self.bootstrap article_url
    domain = URL.new(article_url).domain
    campaign = Campaign.fetch_by_domain domain
    testimonial = Testimonials.for_campaign campaign.id
    campaign_meter = CampaignMeter.for_campaign campaign.id
    {
      article_url: article_url,
      domain: domain,
      foundation_name: campaign.foundation_name,
      publisher_name: campaign.publisher_name,
      testimonial: testimonial,
      value_per_share: campaign.value_per_share.to_i
    }.merge campaign_meter
  end
end
