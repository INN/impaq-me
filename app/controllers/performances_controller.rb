class PerformancesController < ApplicationController
  layout 'performance'
  before_action :check_user

  before_action ->{
    @campaign = Campaign.find(params[:campaign_id])
    @performance = Performance.new(@campaign)
  }

  def show
  end

  def shares
    render :csv => articles_csv(:most_shared_articles),
      :filename => "#{@campaign.publisher_name.parameterize}-shares"
  end

  def clicks
    render :csv => articles_csv(:most_clicked_articles),
      :filename => "#{@campaign.publisher_name.parameterize}-clicks"
  end

private

  def articles_csv(method)
    CSV.generate do |csv|
      csv << ["URL", "Facebook", "Twitter", "E-mail"]
      @performance.send(method, nil).each do |a|
        csv << [a.url, a.facebook, a.twitter, a.email]
      end
    end
  end
end
