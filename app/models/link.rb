class Link
  include Mongoid::Document

  field :long_url
  field :channel
  field :slug

  belongs_to :campaign

  before_save :generate_slug

  def generate_slug
    self.slug = id.to_s[0..9]
  end

end
