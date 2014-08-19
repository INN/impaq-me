class IframeController < ApplicationController
  layout 'iframe'

  def index
    if @campaign = Iframe.bootstrap(params[:article_url], params[:article_title], request.ip)
      render :index
    else
      render :empty
    end
  end

end
