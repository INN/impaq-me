class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :name, :publisher_name, :domains, :value_per_share
end
