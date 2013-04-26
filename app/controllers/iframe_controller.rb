class IframeController < ApplicationController
  before_action :set_bootstrap, only: [:index]
  def index
  end

  def set_bootstrap
    if params[:domain]
      @bootstrap = Iframe.bootstrap(params[:domain])
    else
      hi_jason = '<<<<<HI JASON>>>>>>go to /?domain=domain.com after creating some dummy data'
      @bootstrap = {
        publisher_name: hi_jason,
        foundation_name: "foundation name",
        testimonial: hi_jason
      }
    end
  end

  def bootstrap_params
    params.permit(:domain)
  end
end
