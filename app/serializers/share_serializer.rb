class ShareSerializer < ActiveModel::Serializer
  attributes :campaign_id, :share_method, :message, :ip
end
