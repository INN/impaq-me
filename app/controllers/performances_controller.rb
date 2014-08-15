class PerformancesController < ApplicationController
  layout 'foundation'
  before_action :check_user

  def show
    @campaign = Campaign.find(params[:campaign_id])
    @performance = Performance.new(@campaign)
  end
end
