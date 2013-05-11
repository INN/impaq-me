class DashboardController < ApplicationController
  def index
    @shares = Share.all
    @campaigns = Campaign.all
  end
end
