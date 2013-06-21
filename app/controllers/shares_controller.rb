class SharesController < ApplicationController
  before_action :set_share, only: [:show, :edit, :update, :destroy]
  before_action :check_user

  # GET /shares
  def index
    @shares = Share.all
    respond_to do |format|
      format.json { render json: @shares }
      format.csv { render text: @shares.to_csv }
    end
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
    h = {
      ip: request.ip,
      referer: request.referer
    }
    @share = Share.new(share_params.merge(h))
  end

  def share_params
    params.require(:share).permit(:campaign_id, :channel, :article_url)
  end
end
