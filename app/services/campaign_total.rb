class CampaignTotal
  def self.for_id id
    goal = Share.total_for id: id
    total = Campaign.goal_for id: id
    { goal: goal, total: total }
  end
end
