class SharesController < ApplicationController
  before_action :set_share, only: [:show, :edit, :update, :destroy]

  # GET /shares
  def index
    @shares = Share.all
    render :json => @shares
  end

  # GET /shares/1
  def show
    render :json => @share
  end

  # GET /shares/new
  def new
  end

  # GET /shares/1/edit
  def edit
  end

  # POST /shares
  def create
    build_share
    if @share.save!
      render :json => @share
    else
      render action: 'new'
    end
  end

  private
    def set_share
      @share = Share.find(params[:id])
    end

    def build_share
      @share = Share.new(share_params.merge(ip: request.env.fetch("REMOTE_ADDR")))
    end

    def share_params
      params.require(:share).permit(:campaign_id, :channel)
    end
end
