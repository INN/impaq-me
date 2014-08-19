require 'cleans_urls'

class Article < ActiveRecord::Base
  belongs_to :campaign

  has_many :links
  has_many :shares
  has_many :click_throughs

  before_save :massage_url_before_save

  def self.for(campaign, url)
    Article.find_by(:campaign => campaign, :url => CleansUrls.new(url).to_s)
  end

private

  def massage_url_before_save
    self.url = CleansUrls.new(self.url).to_s
  end
end
