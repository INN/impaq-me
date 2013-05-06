class Shortlink
  def self.for_campaign_and_url(campaign_id, long_url)

    twitter = Link.find_or_create_by({
      campaign_id: campaign_id,
      long_url: long_url,
      channel: 'twitter'
    })

    facebook = Link.find_or_create_by({
      campaign_id: campaign_id,
      long_url: long_url,
      channel: 'facebook'
    })

    {
      twitter_shortlink: twitter.id,
      facebook_shortlink: facebook.id
    }
  end

  def self.follow(long_url)
    URL.new(long_url).tap do |destination_url|
      destination_url.params[:shared_via_impaq_me] = true
    end
  end
end
