class Link < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :article

  before_create :generate_slug, unless: "slug"

  def self.find_or_create_for!(url, campaign, channel)
    clean_url = CleansUrls.new(url).to_s

    find_or_create_by!({
      :campaign => campaign,
      :long_url => clean_url,
      :channel => channel
    }).tap do |link|
      unless link.article_id?
        link.update!(
          :article => Article.find_or_create_by!(:campaign => campaign, :url => clean_url)
        )
      end
    end
  end

  def generate_slug
    new_slug = SecureRandom.urlsafe_base64(7)
    slug_present?(new_slug) ? self.slug = new_slug : generate_slug
  end

  def slug_present?(new_slug)
    self.class.where(slug: new_slug).empty?
  end

end
