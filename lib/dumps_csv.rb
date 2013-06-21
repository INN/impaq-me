module DumpsCSV

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def to_csv
      CSV.generate do |csv|
        csv << headers = fields.keys
        each do |row|
          csv << row.csv_dump(headers)
        end
      end
    end
  end

  def csv_headers
    attributes.keys
  end

  def csv_dump(headers)
    attributes.values_at(*headers)
  end
end
