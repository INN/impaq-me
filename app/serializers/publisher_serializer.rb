class PublisherSerializer < ActiveModel::Serializer
  attributes :id, :paypal_link, :limit
  has_one :campaign
end
