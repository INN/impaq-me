class Share
  include Mongoid::Document

  field :campaign_id
  field :share_method
  field :message
  field :ip

  def self.total_for(campaign_id: campaign_id)
    total = Share.where( campaign_id: campaign_id ).count
    total
  end
end
