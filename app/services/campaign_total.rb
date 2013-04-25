class CampaignTotal
  def self.for_id id
    total = Share.total_for campaign_id: id
    # goal = Campaign.goal_for id: id
    goal = 100 #TODO un-hard-code this
    { campaign_id: id, goal: goal, total: total }
  end
end
