require 'dumps_csv'

class Campaign < ActiveRecord::Base
  class NoGoal < RuntimeError; end
  include DumpsCsv

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

  def self.find_by_domain(domain_name)
    where('? = ANY (domains)', domain_name).first
  end

  def self.goal(id)
    find(id).goal or raise NoGoal
  end

  def domains_to_s
    domains.join(', ') if domains
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
