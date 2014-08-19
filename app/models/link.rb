class Link < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :article

  before_create :generate_slug, unless: "slug"

  def generate_slug
    new_slug = SecureRandom.urlsafe_base64(7)
    slug_present?(new_slug) ? self.slug = new_slug : generate_slug
  end

  def slug_present?(new_slug)
    self.class.where(slug: new_slug).empty?
  end
end
