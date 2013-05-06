class Share
  include Mongoid::Document

  field :campaign_id
  field :channel
  # field :ip
  # TODO capture ip

  belongs_to :campaign

  def self.total_for(campaign_id: campaign_id)
    where(campaign_id: campaign_id).count
  end

end
