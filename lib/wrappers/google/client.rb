require 'google/api_client'

module Wrappers
  module Google
    class Client
      def initialize
        @client = ::Google::APIClient.new
        @client.authorization = ::Signet::OAuth2::Client.new(
          :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
          :audience             => 'https://accounts.google.com/o/oauth2/token',
          :scope                => 'https://www.googleapis.com/auth/analytics.readonly',
          :issuer               => ENV['IMPAQME_GOOGLE_ACCOUNT'],
          :signing_key          => ::OpenSSL::PKey::RSA.new(ENV['IMPAQME_GOOGLE_API_KEY'], 'notasecret')
        ).tap { |auth| auth.fetch_access_token! }
      end

      def analytics_api
        @@analytics_api ||= @client.discovered_api('analytics','v3')
      end

      def execute(options)
        @client.execute(options)
      end

    end
  end
end
