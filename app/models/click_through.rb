class ClickThrough
  include Mongoid::Document

  field :ip
  field :channel
  field :long_url
  field :referer
  field :timestamp, default: DateTime.now

  belongs_to :campaign
  belongs_to :link

  def self.to_csv
    CSV.generate do |csv|
      csv << fields_to_a
      each do |click|
        csv << click.attributes.values_at(*fields_to_a)
      end
    end
  end

  def self.fields_to_a
    self.fields.map { |field| field[0] }
  end
end
