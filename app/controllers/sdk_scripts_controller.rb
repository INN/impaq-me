class SdkScriptsController < ApplicationController
  def show
    redirect_to asset_host + self.class.helpers.asset_path("lineman/sdk/impaq-me-sdk.min.js")
  end
end
