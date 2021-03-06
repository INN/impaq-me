require 'addressable/uri'

class Iframe
  def self.bootstrap(article_url, article_title, user_address)
    article_url = Addressable::URI.heuristic_parse(article_url).normalize
    campaign = Campaign.find_active_campaign_by_domain(article_url.host)
    return unless campaign.present?
    campaign_meter = CampaignMeter.for_campaign(campaign)
    shortlink = Shortlink.for_campaign_and_url(campaign, article_url.to_s)
    sample_variant = SampleVariant.choose_from(campaign.variants)

    {
      user_address: user_address,
      campaign_id: campaign.id.to_s,
      variant_id: sample_variant.id.to_s,
      article_url: article_url.to_s,
      article_domain: article_url.authority,
      article_title: article_title,
      domain: article_url.host,
      foundation_name: campaign.foundation_name,
      publisher_name: campaign.publisher_name,
      share_cooldown_days: campaign.share_cooldown_days,
      value_per_share: format_dollar(campaign.value_per_share),
      value_per_click: format_dollar(campaign.value_per_click),
      paypal_email: campaign.paypal_email,
      twitter_username: campaign.twitter_username,
      widget_header: sample_variant.widget_header,
      widget_solicit: sample_variant.widget_solicit,
      widget_follow_up_cta: sample_variant.widget_follow_up_cta,
      widget_thanks: sample_variant.widget_thanks,
      banner_thanks: sample_variant.banner_thanks,
      email_body: sample_variant.email_body,
      css_overrides: sample_variant.css_overrides,
      recommended_donation: format_dollar(sample_variant.recommended_donation),
      goal: format_dollar(campaign_meter.goal),
      total: format_dollar(campaign_meter.total),
      percent: campaign_meter.percent,
      facebook_app_id: ENV['IMPAQ_ME_FACEBOOK_APP_ID']
    }.merge(shortlink)
  end

  def self.format_dollar(x)
    if x % 1 == 0
      x.to_i
    else
      x.round 2
    end
  end

end
