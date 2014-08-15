class DashboardController < ApplicationController
  layout 'foundation'
  before_action :check_user

  def index
    @shares = Share.all
    @campaigns = Campaign.all
  end
end
