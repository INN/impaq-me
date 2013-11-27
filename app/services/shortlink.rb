require 'addressable/uri'

class Shortlink
  def self.for_campaign_and_url(campaign, long_url)

    long_url = remove_banner_toggle(long_url).to_s

    twitter = Link.find_or_create_by({
      campaign: campaign,
      long_url: long_url,
      channel: 'twitter'
    })

    electronic_mail = Link.find_or_create_by({
      campaign: campaign,
      long_url: long_url,
      channel: 'email'
    })

    facebook = Link.find_or_create_by({
      campaign: campaign,
      long_url: long_url,
      channel: 'facebook'
    })

    {
      twitter_shortlink: "l/#{twitter.slug}",
      facebook_shortlink: "l/#{facebook.slug}",
      email_shortlink: "l/#{electronic_mail.slug}",
    }
  end

  def self.follow(link: link, remote_ip: remote_ip, referer: referer, user_agent: user_agent)
    ClickThrough.create(
      campaign: link.campaign,
      article_url: link.long_url,
      channel: link.channel,
      ip: remote_ip,
      referer: referer,
      user_agent: user_agent
    )
    add_analytics_query_params link.long_url, link.campaign
  end

  private

  def self.remove_banner_toggle long_url
    Addressable::URI.parse(long_url).tap do |url|
      url.query_values = (url.query_values || {}).except('shared_via_impaq_me')
    end
  end

  def self.add_analytics_query_params long_url, campaign
    Addressable::URI.parse(long_url).tap do |url|
      url.query_values = (url.query_values || {}).merge(shared_via_impaq_me: true,
                                                        utm_source: 'impaqme',
                                                        utm_medium: 'social',
                                                        utm_campaign: campaign.id)

    end
  end
end
