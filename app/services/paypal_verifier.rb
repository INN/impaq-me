class PaypalVerifier
  include ActiveMerchant::Billing::Integrations

  def self.acknowledge(raw_post)
    notification = Paypal::Notification.new(raw_post)
    notification.acknowledge
  end
end
