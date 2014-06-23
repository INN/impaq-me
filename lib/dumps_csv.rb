module DumpsCsv

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def to_csv(rejections=[])
      CSV.generate do |csv|
        csv << headers = self.attribute_names.reject do |attr_name|
          rejections.include?(attr_name)
        end
        self.all.each do |row|
          csv << row.csv_dump(headers)
        end
      end
    end
  end

  def csv_dump(headers)
    attributes.values_at(*headers)
  end
end
