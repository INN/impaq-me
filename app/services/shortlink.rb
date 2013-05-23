require 'addressable/uri'

class Shortlink
  def self.for_campaign_and_url(campaign, long_url)

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
    Addressable::URI.parse(link.long_url).tap do |url|
      ClickThrough.create(
        campaign: link.campaign,
        article_url: url.to_s,
        channel: link.channel,
        ip: remote_ip,
        referer: referer,
        user_agent: user_agent
      )
      url.query_values = (url.query_values || {}).merge 'shared_via_impaq_me' => true
    end
  end
end
