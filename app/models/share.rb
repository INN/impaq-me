class Share
  include Mongoid::Document

  field :campaign_id
  field :share_method
  field :message
  field :ip
end
