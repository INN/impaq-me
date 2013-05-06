class LinksController < ApplicationController
  before_action :set_link, only: [:show, :follow]

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
    #TODO increment clicks
    redirect_to Shortlink.follow(@link.long_url).to_s
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

end
