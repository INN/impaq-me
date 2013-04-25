class CampaignMeterController < ApplicationController
  def index
    render :json => CampaignTotal.for_id(params[:campaign_id])
  end
end
