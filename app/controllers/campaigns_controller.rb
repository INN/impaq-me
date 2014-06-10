class CampaignsController < ApplicationController
  layout 'foundation'
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :check_user

  # GET /campaigns
  def index
    @campaigns = Campaign.all
    respond_to do |format|
      format.html { redirect_to :dashboard_index }
      format.json { render json: @campaigns }
      format.csv { render text: @campaigns.to_csv(Campaign::FIELDS_TO_EXCLUDE_FROM_CSV) }
    end
  end

  # GET /campaigns/1
  def show
    redirect_to :dashboard_index
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
    @campaign.variants.build
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      redirect_to :dashboard_index, notice: 'Campaign was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    if @campaign.update_attributes(campaign_params)
      redirect_to :dashboard_index, notice: 'Campaign was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign.destroy
    redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def campaign_params
    p = params.require(:campaign).permit(:foundation_name, :publisher_name,
                                         :domains, :value_per_share, :goal,
                                         :value_per_click, :about_uri,
                                         :share_cooldown_days, :paypal_email,
                                         :twitter_username,
                                         variants_attributes: [:id, :recommended_donation,
                                           :widget_header, :widget_solicit,
                                           :widget_follow_up_cta, :widget_thanks,
                                           :banner_thanks, :email_body, :css_overrides,
                                           :shown_amount])
    p.tap do |p|
      p[:domains] = p[:domains].split ","
      p[:domains].each { |d| d.strip! }
    end
  end
end
