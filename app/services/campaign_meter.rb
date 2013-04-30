class CampaignMeter
  def self.for_campaign id
    goal = Campaign.goal_for id: id
    total = Share.total_for campaign_id: id
    percent = total/goal * 100
    {
      campaign_id: id,
      goal: goal,
      total: total,
      percent: percent
    }
  end
end
