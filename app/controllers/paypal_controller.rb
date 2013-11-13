class PaypalController < ApplicationController
  protect_from_forgery except: :callback

  def callback
    PaypalDonation.create(paypal_params) if valid_handshake?
    render nothing: true, status: :ok
  end

  private
  def paypal_params
    params.permit!
  end

  def valid_handshake?
    PaypalVerifier.acknowledge(request.raw_post)
  end
end
