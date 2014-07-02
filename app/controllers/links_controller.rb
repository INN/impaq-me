require 'open-uri'

class LinksController < ApplicationController
  before_action :set_link, only: [:show, :follow]
  before_action :check_user, except: :follow
  layout 'links'

  def index
    @links = Link.all
    render :json => @links
  end

  def show
    render :json => @link
  end

  def follow
    @url = Shortlink.follow(shortlink_params).to_s
    if params[:facebot] || request.user_agent.start_with?("facebookexternalhit")
      open(@url) do |io|
        @proxy_content = io.read.
          gsub(/rel\=.?canonical.?/, 'rel="not-canonical"').
          gsub(/property=.?og:url.?/, 'property="not:og:url"')
      end

      render :follow
    else
      redirect_to(@url)
    end
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
