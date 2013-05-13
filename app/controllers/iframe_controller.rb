class IframeController < ApplicationController
  before_action :set_bootstrap_models, only: [:index]
  before_action :set_old_big_bootstrap, only: [:index]

  def index
  end

  private
  def set_bootstrap_models
    @publisher = Publisher.find bootstrap_params[:publisher_id]
    @campaign = @publisher.campaign
    @shortlink = Shortlink.for_campaign_and_url @campaign.id, bootstrap_params[:article_url]
    @campaign_meter = CampaignMeter.for @campaign
  end

  def set_old_big_bootstrap
    @publisher = Publisher.find bootstrap_params[:publisher_id]
    @impaqme = Iframe.bootstrap(@publisher, :article_url)
  end

  def bootstrap_params
    params.permit(:article_url, :publisher_id)
  end
end
