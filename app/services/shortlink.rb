require 'addressable/uri'
require 'cleans_urls'

class Shortlink
  def self.for_campaign_and_url(campaign, long_url)
    long_url = CleansUrls.new(long_url).to_s
    Hash[['twitter', 'facebook', 'email'].map do |channel|
      ["#{channel}_shortlink".to_sym, "l/#{Link.find_or_create_by({
        :campaign => campaign,
        :article => Article.find_or_create_by(:campaign => campaign, :url => long_url),
        :long_url => long_url,
        :channel => channel,
      }).slug}"]
    end]
  end

  def self.follow(link: link, remote_ip: remote_ip, referer: referer, user_agent: user_agent)
    url = link.article.try(:url) || link.long_url
    ClickThrough.create!(
      :campaign => link.campaign,
      :article => link.article,
      :article_url => url,
      :channel => link.channel,
      :ip => remote_ip,
      :referer => referer,
      :user_agent => user_agent
    )
    url_with_google_analytics(url, link.campaign)
  end

private

  def self.url_with_google_analytics(url_string, campaign)
    Addressable::URI.parse(url_string).tap do |url|
      url.query_values = (url.query_values || {}).merge(
        :shared_via_impaq_me => true,
        :utm_source => 'impaqme',
        :utm_medium => 'social',
        :utm_campaign => campaign.id
      )
    end
  end
end
