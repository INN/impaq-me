class LinksController < ApplicationController
  before_action :set_link, only: [:show]

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
    @link = Link.find(params[:slug])
    redirect_to Shortlink.follow(@link).to_s
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

end
