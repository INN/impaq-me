class Share
  include Mongoid::Document

  field :ip
  field :facebook
  field :twitter
  field :message
  field :url
end
