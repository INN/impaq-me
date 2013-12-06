class PaypalDonationsController < ApplicationController
  layout false

  protect_from_forgery except: :callback

  def index
    @paypal_donations = PaypalDonation.all
    respond_to do |format|
      format.json { render json: @paypal_donations }
      format.csv { render text: @paypal_donations.to_csv }
    end
  end

  def callback
    params.permit!
    if valid_handshake?
      @paypal_donation = PaypalDonation.new(with_custom_params)
    end
    if @paypal_donation.save!
      render nothing: true, status: :ok
    end
  end

  private
  def with_custom_params
    params.merge(campaign_id: params[:option_selection1],
                 article_url: params[:option_selection2],
                 user_address: params[:option_selection3])
  end

  def valid_handshake?
    PaypalVerifier.acknowledge(request.raw_post)
  end
end
