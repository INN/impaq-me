class SessionsController < ApplicationController
  before_action :session_params, only: [:show]

  def new
  end

  def create
    user = find_user
    if user && user.authenticate(session_params[:password])
      sign_in user
      redirect_to :dashboard_index
    else
      flash.now[:error] = "Invalid user/email combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    render 'new'
  end

  private
  def find_user
    begin
      User.find_by email: session_params[:email]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
