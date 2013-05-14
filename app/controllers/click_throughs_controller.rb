class ClickThroughsController < ApplicationController
  before_action :check_user

  def index
    @clicks = ClickThrough.all
    respond_to do |format|
      format.json { render json: @clicks }
      format.csv { render text: @clicks.to_csv }
    end
  end
end
