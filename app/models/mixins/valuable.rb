# Requires fields:
# - article_url
# - campaign_id
# - ip
# - channel
# - value
# - created_at
#
module Mixins
  module Valuable
    def self.included(base)
      base.extend(ClassMethods)
      base.before_create :set_value, :unless => -> { value.present? }
    end

    def set_value
      self.value = valuable? ? value_per_item : 0.0
    end

    def valuable?
      return false if campaign.met_goal?
      eligible_for_value?
    end

    module ClassMethods

      def total_for_campaign(campaign)
        where(:campaign => campaign).sum(:value)
      end

      def for_channel(channel)
        where({
          :campaign => campaign,
          :channel => channel
        }.compact)
      end

      def past_dupes(model)
        where(
          :article_url => model.article_url,
          :campaign_id => model.campaign_id,
          :ip => model.ip
        ).where.not(
          :id => model.id
        ).order(:created_at)
      end
    end
  end
end
