class CampaignMeter
  def self.for_campaign(campaign)
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
    ClickThrough.total_for_campaign campaign
  end

  def self.share_total campaign
    Share.total_for_campaign campaign
  end
end
