require_relative '../../app/services/campaign_total'

Share = Class.new
Campaign = Class.new
describe CampaignTotal do
  it "takes a campaign identifier and returns a total" do
    Share.stub(:total_for).with(campaign_id: 1) { 85 }
    Campaign.stub(:goal_for).with(campaign_id: 1) { 100 }
    expect(CampaignTotal.for_id(1)).to eq({ campaign_id: 1, goal: 100, total: 85 })
  end
  it "counts one share per ip address"
  it "does not double count FB and twitter shares"
end
