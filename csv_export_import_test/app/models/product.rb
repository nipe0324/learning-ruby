class Product < ActiveRecord::Base
  belongs_to :manufacture

  validates :price, presence: true

end

class ActiveRecord::Base
  # normal find_each does not use given order but uses id asc
  def self.find_each_with_order(options={})
    raise "offset is not yet supported" if options[:offset]

    page = 1
    limit = options[:limit] || 1000

    loop do
      offset = (page-1) * limit
      batch = find(:all, options.merge(:limit => limit, :offset => offset))
      page += 1

      batch.each{|x| yield x }

      break if batch.size < limit
    end
  end
end
