class StaticPagesController < ApplicationController

  def index
    redirect_to 'http://impaqme.org/'
  end

  def about
    redirect_to 'http://impaqme.org/about'
  end

  def funding
    redirect_to 'http://impaqme.org/'
  end
end
