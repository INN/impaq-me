class PaypalDonation < ActiveRecord::Base
  belongs_to :campaign

  def self.for_params(params)
    self.new(params.select {|(k,v)| attribute_names.include?(k) }.merge(
      :json_payload => params.to_json
    ))
  end

  def self.for_campaign(campaign)
    where(campaign: campaign)
  end

  def self.total_for_campaign(campaign)
    for_campaign(campaign).sum(:mc_gross)
  end
end
