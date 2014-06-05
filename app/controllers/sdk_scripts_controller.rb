class SdkScriptsController < ApplicationController
  def show
    sdk_path = self.class.helpers.asset_path("lineman/sdk/impaq-me-sdk.min.js")
    if sdk_path =~ /^http/
      # If this is true then we're on Rails 4.1+ and you can kill the else clause and this branch
      # see https://github.com/rails/rails/issues/10051
      redirect_to(sdk_path)
    else
      redirect_to("#{asset_host}#{sdk_path}")
    end
  end
end
