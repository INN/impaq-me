class CampaignMeter
  def self.for campaign
    percent = (total(campaign)/campaign.goal * 100).round 2
    OpenStruct.new(
      campaign_id: campaign.id,
      goal: campaign.goal,
      total: total(campaign),
      percent: percent
    )
  end

  def self.total campaign
    [share_total(campaign) + click_total(campaign), campaign.goal].min
  end

  def self.click_total campaign
    clicks = ClickThrough.total_for_campaign campaign.id
    click_total = clicks * campaign.value_per_share
  end

  def self.share_total campaign
    shares = Share.total_for_campaign campaign.id
    share_total = shares * campaign.value_per_share
  end
end
