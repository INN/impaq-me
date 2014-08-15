if Rails.env.development?

  #
  # Allow the SDK to force the campaign it wants to its request domain
  #
  require 'campaign'
  class Campaign < ActiveRecord::Base
    def self.assign_domain_to_campaign(domain, id)
      new_campaign = Campaign.find(id)
      Campaign.where('? = ANY (domains)', domain).each do |old|
        old.update(:domains => old.domains - [domain])
      end
      new_campaign.update(:domains => new_campaign.domains + [domain])
    end
  end

  require 'iframe_controller'
  class IframeController < ApplicationController
    alias_method :old_index, :index

    def index
      if params.has_key?(:campaign_id) && Campaign.find_by(:id => params[:campaign_id]).present?
        require 'addressable/uri'
        Campaign.assign_domain_to_campaign(Addressable::URI.heuristic_parse(params[:article_url]).normalize.host, params[:campaign_id])
      end
      old_index
    end
  end

  #
  # Allow remote debugging
  #
  Debugger.start_remote
end
