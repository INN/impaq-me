class CampaignMeter
  def self.for_campaign id
    goal = Campaign.goal_for id: id
    total = Share.total_for campaign_id: id
    { campaign_id: id, goal: goal, total: total }
  end
end
