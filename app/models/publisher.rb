class Publisher
  include Mongoid::Document
  field :name, type: String
  field :paypal_link, type: String
  field :limit, type: Integer
  belongs_to :campaign
end
