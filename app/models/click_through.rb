class ClickThrough
  include Mongoid::Document

  field :ip
  field :channel
  field :long_url
  field :referer
  field :timestamp, default: DateTime.now

  belongs_to :campaign
  belongs_to :link

end
