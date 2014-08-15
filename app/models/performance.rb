class Performance
  attr_reader :pageview_count, :pageview_percent_shared, :pageview_percent_donated,
    :donation_count, :donation_sum, :donation_average,
    :most_shared_articles,
    :most_clicked_articles


  def initialize(campaign)
    @campaign = campaign
    @dollars_raised = 0
  end

  def dollars_raised
    [dollars_hypothetically_raised, dollars_goal]
  end

  def dollars_hypothetically_raised
    share_count * @campaign.value_per_share +
    click_count * @campaign.value_per_click
  end

  def dollars_goal
    @campaign.goal
  end


  def share_count(channel = :all)
    "TODO #{channel}"
  end

  def click_count(channel = :all)
    "TODO #{channel}"
  end

  def clicks_per_share(channel = :all)
    "TODO #{channel}"
  end
end
