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
      twitter_shortlink: twitter.slug,
      facebook_shortlink: facebook.slug,
      email_shortlink: electronic_mail.slug,
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
    add_banner_toggle link.long_url
  end

  private

  def self.remove_banner_toggle long_url
    Addressable::URI.parse(long_url).tap do |url|
      url.query_values = (url.query_values || {}).except('shared_via_impaq_me')
    end
  end

  def self.add_banner_toggle long_url
    Addressable::URI.parse(long_url).tap do |url|
      url.query_values = (url.query_values || {}).merge 'shared_via_impaq_me' => true
    end
  end

end
