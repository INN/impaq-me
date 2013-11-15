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
    PaypalDonation.create(with_custom_params) if valid_handshake?
    render nothing: true, status: :ok
  end

  private
  def paypal_params
    params.permit!
  end

  def with_custom_params
    paypal_params.merge(campaign_id: paypal_params['option_selection1'],
                        article_url: paypal_params['option_selection2'],
                        user_address: paypal_params['option_selection3'])
  end

  def valid_handshake?
    PaypalVerifier.acknowledge(request.raw_post)
  end
end
