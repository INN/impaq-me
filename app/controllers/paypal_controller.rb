class PaypalController < ApplicationController
  layout false

  protect_from_forgery except: :callback

  def callback
    PaypalDonation.create(with_campaign_id) if valid_handshake?
    render nothing: true, status: :ok
  end

  private
  def paypal_params
    params.permit!
  end

  def with_campaign_id
    paypal_params.merge(campaign_id: paypal_params['option_selection1'])
  end

  def valid_handshake?
    PaypalVerifier.acknowledge(request.raw_post)
  end
end
