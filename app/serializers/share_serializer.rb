class ShareSerializer < ActiveModel::Serializer
  attributes :id, :campaign_id, :channel, :ip
end
