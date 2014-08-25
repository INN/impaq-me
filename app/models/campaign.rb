require 'dumps_csv'

class Campaign < ActiveRecord::Base
  include DumpsCsv
  default_scope ->{ where(:deleted => false) }

  validates_uniqueness_of :mongo_id, :allow_nil => true

  has_many :shares
  has_many :links
  has_many :click_throughs
  has_many :paypal_donations
  has_many :variants
  accepts_nested_attributes_for :variants


  FIELDS_TO_EXCLUDE_FROM_CSV = ['widget_header', 'widget_solicit', 'widget_follow_up_cta',
                                'widget_thanks', 'banner_thanks', 'email_body', 'css_overrides']


  validates :variants, length: { minimum: 1 }
  validate :sum_of_shown_amounts_is_one_hundred

  def self.find_active_campaign_by_domain(domain_name)
    all
      .merge(for_domain(domain_name))
      .merge(active?)
      .first
  end

  def self.active?
    all
      .where(:disabled => false)
      .where('starts_at is null or starts_at <= ?', ActiveSupport::TimeZone.new('Eastern Time (US & Canada)').now.beginning_of_day.utc)
      .where('ends_at is null or ends_at >= ?', ActiveSupport::TimeZone.new('Eastern Time (US & Canada)').now.end_of_day.utc)
  end

  def self.for_domain(domain_name)
    where('? = ANY (domains)', domain_name)
  end

  def self.undelete!(id)
    unscoped.find(id).update(:deleted => false)
  end

  def domains_to_s
    domains.join(', ') if domains
  end

  def last_monied_event_at
    [shares, click_throughs].map do |r|
      r.where('value > 0').order('created_at desc').first.try(:created_at)
    end.compact.max
  end

private

  def sum_of_shown_amounts_is_one_hundred
    unless total_shown_amount == Variant::MAX_SHOWN_AMOUNT
      errors.add(:shown_amount, 'sum of all variants must equal 100%')
    end
  end

  def total_shown_amount
    variants.inject(0) { |sum, variant| sum + variant.shown_amount }
  end
end
