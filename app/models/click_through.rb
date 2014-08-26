require 'yaml'
require 'dumps_csv'

class ClickThrough < ActiveRecord::Base
  include DumpsCsv
  include Mixins::Valuable

  belongs_to :campaign
  belongs_to :article

  USER_AGENT_BLACKLIST = Regexp.union(YAML.load_file(Rails.root.join('config/user_agent_blacklist.yml')))

  # Required by Mixins::Valuable
  def value_per_item
    campaign.value_per_click
  end

  # Required by Mixins::Valuable
  def eligible_for_value?
    return false if blacklisted_agent?
    self.class.past_dupes(self).empty?
  end

private

  def blacklisted_agent?
    user_agent =~ USER_AGENT_BLACKLIST
  end
end
