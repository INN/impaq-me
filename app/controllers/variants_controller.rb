class VariantsController < ApplicationController
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.variants << Variant.new
    redirect_to edit_campaign_url(@campaign)
  end
end
