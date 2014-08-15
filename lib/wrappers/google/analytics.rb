require 'wrappers/google/client'

module Wrappers
  module Google
    class Analytics
      def initialize
        @client = Client.new
      end

      # To play with this in a REPL
      # require 'wrappers/google/analytics'; analytics = Wrappers::Google::Analytics.new; f = analytics.pageviews_for_campaign(Campaign.new(:id => 16))
      #   => 162928
      def pageviews_for_campaign(campaign)
        campaign_id = campaign.mongo_id? ? campaign.mongo_id : campaign.id

        pageviews_for_campaign_result(@client.execute(
          :api_method => @client.analytics_api.data.ga.get,
          :parameters => {
            'ids' => "ga:#{ENV['IMPAQME_GOOGLE_PROFILE']}",
            'start-date' => Date.new(2012,1,1).to_s,
            'end-date' => Date.today.to_s,
            'dimensions' => 'ga:dimension1',
            'metrics' => 'ga:pageviews',
            'filters' => "ga:dimension1==#{campaign_id}"
          }
        ))
      end

    private

      # Result looks like this:
      # result.data.rows => [["16", "162908"]] # [ [campaignId, pageViewCount] ]
      #
      # So we want to grab the first (only) element in the array, then the
      # second element in the result
      def pageviews_for_campaign_result(result)
        result.data.rows.first[1].to_i
      end

    end
  end
end
