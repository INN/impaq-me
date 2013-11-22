class SampleVariant
  def self.choose_from(variants)
    chosen = (1..Variant::MAX_SHOWN_AMOUNT).to_a.sample
    variants.each do |variant|
      chosen -= variant.shown_amount
      return variant if chosen <= 0
    end
  end
end
