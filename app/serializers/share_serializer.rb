class ShareSerializer < ActiveModel::Serializer
  attributes :id, :ip, :facebook, :twitter, :message, :url
end
