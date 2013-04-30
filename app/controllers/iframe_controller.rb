class IframeController < ApplicationController
  before_action :set_campaign, only: [:index]

  def index
  end

  def set_campaign
    @campaign = Iframe.bootstrap(params[:article_url])
  end

  def bootstrap_params
    params.permit(:article_url)
  end
end
