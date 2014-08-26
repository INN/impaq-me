require 'dumps_csv'
require 'cleans_urls'

class Share < ActiveRecord::Base
  include DumpsCsv
  include Mixins::Valuable

  belongs_to :campaign
  belongs_to :article

  def self.create_from_params!(params)
    url = CleansUrls.new(params[:article_url]).to_s
    Share.create!(params.merge(
      :article_url => url,
      :article => Article.for(params[:campaign_id], url)
    ))
  end

  # Required by Mixins::Valuable
  def value_per_item
    campaign.value_per_share
  end

  # Required by Mixins::Valuable
  def eligible_for_value?
    if most_recent_past_duplicate_share = self.class.past_dupes(self).last
      (Time.zone.now - most_recent_past_duplicate_share.created_at) > campaign.share_cooldown_days.days
    else
      true
    end
  end
end
