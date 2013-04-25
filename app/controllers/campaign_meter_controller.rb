class CampaignMeterController < ApplicationController
  def index
    render :json => { id: 1, goal: 100, total: 87 }
  end
end
