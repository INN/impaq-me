class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]
  before_action :check_user

  def index
    @publishers = Publisher.all
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def edit
  end

  def create
    @publisher = Publisher.new(publisher_params)

    if @publisher.save
      redirect_to @publisher, notice: 'Publisher was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @publisher.update_attributes!(publisher_params)
      redirect_to @publisher, notice: 'Publisher was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @publisher.destroy
    redirect_to publishers_url, notice: 'Publisher was successfully destroyed.'
  end

  private
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    def publisher_params
      params.require(:publisher).permit(:name, :paypal_link, :limit, :campaign_id)
    end
end
