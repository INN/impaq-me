require 'dumps_csv'

class PaypalDonation < ActiveRecord::Base
  include DumpsCsv
  belongs_to :campaign

  def self.for_params(params)
    self.new(params.select {|(k,v)| attribute_names.include?(k) }.merge(
      :json_payload => params.to_json
    ))
  end

  def self.total_for_campaign(campaign)
    where(:campaign => campaign).sum(:mc_gross)
  end
end
