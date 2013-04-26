class CampaignMeterController < ApplicationController
  def index
    render :json => CampaignMeter.for_campaign(params[:campaign_id])
  end
end
