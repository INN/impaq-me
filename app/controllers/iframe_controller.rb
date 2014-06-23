class IframeController < ApplicationController
  layout 'iframe'

  def index
    if @campaign = Iframe.bootstrap(Article.new(bootstrap_params[:article_url], bootstrap_params[:article_title]), request.ip)
      render :index
    else
      render :empty
    end
  end

  def bootstrap_params
    params.permit(:article_url, :article_title)
  end
end

Article = Struct.new(:url, :title)
