require 'addressable/uri'

class Shortlink
  def self.for_campaign_and_url(campaign_id, long_url)

    twitter = Link.find_or_create_by({
      campaign_id: campaign_id,
      long_url: long_url,
      channel: 'twitter'
    })

    electronic_mail = Link.find_or_create_by({
      campaign_id: campaign_id,
      long_url: long_url,
      channel: 'email'
    })

    facebook = Link.find_or_create_by({
      campaign_id: campaign_id,
      long_url: long_url,
      channel: 'facebook'
    })

    {
      twitter_shortlink: twitter.id,
      facebook_shortlink: facebook.id,
      email_shortlink: electronic_mail.id,
    }
  end

  def self.follow(link: link, remote_ip: remote_ip, referer: referer)
    link.clicks += 1
    link.save
    link.create_click_through remote_ip, referer
    Addressable::URI.parse(link.long_url).tap do |url|
      url.query_values = (url.query_values || {}).merge 'shared_via_impaq_me' => true
    end
  end
end
