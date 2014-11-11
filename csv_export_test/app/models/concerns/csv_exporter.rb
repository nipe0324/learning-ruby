module CsvExporter
  def csv(query)
    CSV.generate do |csv|
      csv << self.header
      self.query.each do |element|
        csv << to_row(element)
      end
    end
  end

  def to_row(product)
    attributes = Hash[[self.header, self.values(product)].transpose]
    attributes.values_at(*self.header)
  end
end
