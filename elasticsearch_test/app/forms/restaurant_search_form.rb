class RestaurantSearchForm
  include ActiveModel::Model

  attr_accessor :query, :page

  def search
    ::Restaurant.search(query).page(page).results
    # t = ::Restaurant.arel_table
    # # NOTE: 20万件表示しようとすると止まってしまうのでlimitメソッドで制限をかけておく
    # results = ::Restaurant.all.order(:created_at).limit(100)
    # results = results.where(contains(t[:name], query).or(contains(t[:name_kana], query))) if query.present?
    # results
  end

  # private

  #   def contains(arel_attribute, value)
  #     arel_attribute.matches("%#{escape_like(value)}%")
  #   end

  #   def escape_like(string)
  #     string.gsub(/[\\%_]/) { |m| "\\#{m}" }
  #   end
end
