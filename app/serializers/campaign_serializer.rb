class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
    :foundation_name,
    :publisher_name,
    :domains,
    :value_per_share,
    :goal
end
