module CampaignsHelper
  def eastern_date(time)
    return unless time.present?
    time.in_time_zone('Eastern Time (US & Canada)').to_date
  end
end
