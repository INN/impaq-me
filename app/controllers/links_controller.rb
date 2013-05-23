class LinksController < ApplicationController
  before_action :set_link, only: [:show, :follow]

  def index
    @links = Link.all
    render :json => @links
  end

  def show
    render :json => @link
  end

  def follow
    redirect_to Shortlink.follow(shortlink_params).to_s
  end

  private

  def shortlink_params
    {
      link: @link,
      remote_ip: request.ip,
      referer: request.referer,
      user_agent: request.user_agent
    }
  end

  def remote_ip
    # request.env.fetch("HTTP_CLIENT_IP")
  end

  def set_link
    @link = Link.find_by(link_params)
  end

  def link_params
    { slug: params.require(:slug) }
  end

end
