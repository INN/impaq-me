class VariantsController < ApplicationController
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.variants << Variant.new
    redirect_to edit_campaign_url(@campaign)
  end

  def destroy
    Variant.find(params[:id]).destroy
    redirect_to campaigns_url, notice: 'Variant was successfully destroyed.'
  end
end
