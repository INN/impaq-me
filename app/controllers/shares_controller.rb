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
    @share = Share.new
    render :json => @share
  end

  # GET /shares/1/edit
  def edit
  end

  # POST /shares
  def create
    @share = Share.new(share_params)

    if @share.save
      redirect_to @share, notice: 'Share was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /shares/1
  def update
    if @share.update(share_params)
      redirect_to @share, notice: 'Share was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /shares/1
  def destroy
    @share.destroy
    redirect_to shares_url, notice: 'Share was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share
      @share = Share.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def share_params
      params.require(:share).permit(:ip, :facebook, :twitter, :message, :url)
    end
end
