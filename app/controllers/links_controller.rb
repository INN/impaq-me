class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :follow]

  # GET /links
  def index
    @links = Link.all
    render :json => @links
  end

  # GET /links/1
  def show
    render :json => @link
  end

  def follow
    #TODO use the correct HTTP status code
    redirect_to @link.long_url
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params[:link].require(:campaign_id)
      params[:link].permit(:campaign_id, :share_method, :message, :ip)
    end
end
