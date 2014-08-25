require 'bigdecimal'
require 'bigdecimal/util'
require 'wrappers/google/analytics';

class Performance
  attr_reader :pageview_count

  def initialize(campaign)
    @campaign = campaign
    @dollars_raised = 0
    @pageview_count = Wrappers::Google::Analytics.new.pageviews_for_campaign(@campaign, end_date)
  end

  def dollars_raised
    [dollars_hypothetically_raised, dollars_goal].min
  end

  def dollars_hypothetically_raised
    Share.total_for_campaign(@campaign) + ClickThrough.total_for_campaign(@campaign)
  end

  def dollars_goal
    @campaign.goal
  end

  def donation_count
    PaypalDonation.where(:campaign => @campaign).count
  end

  def donation_sum
    donation_amounts.sum.to_d
  end

  def donation_average
    arithmetic_mean(donation_amounts)
  end

  def pageview_percent_shared
    ((share_count / pageview_count.to_d) * 100).truncate(6)
  end

  def pageview_percent_donated
    ((donation_count / pageview_count.to_d) * 100).truncate(6)
  end

  def share_count(channel = nil)
    for_channel(Share, channel).count
  end

  def click_count(channel = nil)
    for_channel(ClickThrough, channel).count
  end

  def clicks_per_share(channel = nil)
    (click_count(channel).to_d / share_count(channel).to_d).truncate(2)
  end

  ArticlePerformance = Struct.new(:url, :facebook, :twitter, :email, :total)
  def most_shared_articles
    most_x_articles(:shares)
  end

  def most_clicked_articles
    most_x_articles(:click_throughs)
  end

private
  def end_date
    [
      @campaign.ends_at.try(:to_date),
      (@campaign.last_monied_event_at if dollars_raised >= dollars_goal),
      Date.tomorrow
    ].compact.min
  end

  def donation_amounts
    PaypalDonation.where(:campaign => @campaign).map(&:payment_gross)
  end

  def arithmetic_mean(array)
    array.reduce(:+).try(:to_d).try(:/,array.size).truncate(2)
  end

  def for_channel(cls, channel)
    cls.where(
      {:campaign => @campaign}.tap do |h|
        h.merge!(:channel => channel) if channel.present?
      end
    )
  end

  def most_x_articles(relation)
    Article.select("articles.*, count(#{relation}.id) as x_count").
      joins(relation).
      where(:campaign_id => 16).
      group("articles.id").
      order("x_count desc").
    limit(10).map do |article|
      x_by_channel = article.send(relation).group_by(&:channel)
      ArticlePerformance.new(
        article.url,
        x_by_channel["facebook"].try(:size),
        x_by_channel["twitter"].try(:size),
        x_by_channel["email"].try(:size),
        article.send(relation).size
      )
    end
  end

end
