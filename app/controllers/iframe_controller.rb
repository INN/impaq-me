class IframeController < ApplicationController
  layout 'iframe'
  before_action :set_campaign, only: [:index]

  def index
  end

  def set_campaign
    @campaign = Iframe.bootstrap(Article.new(bootstrap_params[:article_url], bootstrap_params[:article_title]), request.ip)
  end

  def bootstrap_params
    params.permit(:article_url, :article_title)
  end
end

Article = Struct.new :url, :title
