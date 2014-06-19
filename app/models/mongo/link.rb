module Mongo
  class Link
    include Mongoid::Document
    store_in collection: "links"

    field :long_url
    field :channel
    field :slug

    index({ slug: 1 }, { unique: true, name: "slug_index" })

    belongs_to :campaign

    before_save :generate_slug

    def generate_slug
      new_slug = SecureRandom.urlsafe_base64 7
      slug_present?(new_slug) ? self.slug = new_slug : generate_slug
    end

    def slug_present? new_slug
      self.class.where(slug: new_slug).empty?
    end
  end
end
