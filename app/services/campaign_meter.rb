class CampaignMeter
  def self.for campaign
    shares = Share.total_for_campaign campaign.id
    total = max((shares * campaign.value_per_share), campaign.goal)
    percent = (total/campaign.goal * 100).round 2
    {
      campaign_id: campaign.id,
      goal: campaign.goal.to_i,
      total: total.to_i,
      percent: percent
    }
  end

  def self.max generated, goal
    if generated <= goal
      generated
    else
      goal
    end
  end
end
