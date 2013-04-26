class Share
  include Mongoid::Document

  field :campaign_id
  field :share_method
  field :message
  field :ip

  belongs_to :campaign

  def self.total_for(campaign_id: campaign_id)
    Share.where( campaign_id: campaign_id ).count
  end
end
