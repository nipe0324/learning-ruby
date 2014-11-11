module CsvExporter
  def csv(query)
    CSV.generate do |csv|
      csv << self.header
      self.query.each do |element|
        csv << row(element)
      end
    end
  end
end
