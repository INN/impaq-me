require 'rails_helper'

describe Share do
  Given(:campaign_value) { 23 }
  Given(:campaign_cooldown) { 4 }
  Given(:campaign) { Campaign.create!(:goal => 5000, :value_per_share => campaign_value, :share_cooldown_days => campaign_cooldown, :variants => [Variant.new(:shown_amount => Variant::MAX_SHOWN_AMOUNT)]) }

  Given(:share_attrs) {{
    :article_url => "http://example.com",
    :campaign => campaign,
    :ip => "1.2.3.4"
  }}

  subject { Share.new(share_attrs) }

  describe "sets value based on past shares" do
    When { subject.save! }

    context "no past shares" do
      Then { subject.value == campaign_value }
    end

    context "there are past shares" do
      Given!(:past_share) { Share.create!(share_attrs) }

      context "past share is not a dupe" do
        Given { past_share.update(:ip => "4.3.2.1") }
        Then { subject.value == campaign_value }
      end

      context "past share IS a dupe" do
        context "past dupe was older than share_cooldown_days ago" do
          Given { past_share.update(:created_at => (campaign_cooldown + 1).days.ago)}
          Then { subject.value == campaign_value }
        end

        context "past dupe was not over share_cooldown_days ago" do
          Given { past_share.update(:created_at => 3.hours.ago)}
          Then { subject.value == 0.0 }
        end
      end
    end

  end
end
