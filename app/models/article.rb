class Article < ActiveRecord::Base
  belongs_to :campaign

  has_many :links
  has_many :shares
  has_many :click_throughs

  before_save :clean_url

private

  # Prevent URL patterns we don't want from being saved to the Article
  # Eventually this will satisfy
  def clean_url
    self.url = self.url.gsub(/\?$/,'')
  end
end
