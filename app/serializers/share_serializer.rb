class ShareSerializer < ActiveModel::Serializer
  attributes :id, :campaign_id, :share_method, :message, :ip
end
