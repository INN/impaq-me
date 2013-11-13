class PaypalDonation
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :campaign_id, type: Moped::BSON::ObjectId
  field :mc_gross, type: Float, default: 0

  belongs_to :campaign

  def self.for_campaign campaign
    where(campaign: campaign)
  end

  def self.total_for_campaign campaign
    for_campaign(campaign).sum(:mc_gross)
  end
end
