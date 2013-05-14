class IframeController < ApplicationController
  before_action :set_campaign, only: [:index]

  def index
  end

  def set_campaign
    @campaign = Iframe.bootstrap(Article.new params[:article_url], params[:article_title])
  end

  def bootstrap_params
    params.permit(:article_url, :article_title)
  end
end

Article = Struct.new :url, :title
