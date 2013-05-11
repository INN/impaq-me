class DashboardController < ApplicationController
  before_action :check_user

  #todo filter signin
  def index
    @shares = Share.all
    @campaigns = Campaign.all
  end
end
