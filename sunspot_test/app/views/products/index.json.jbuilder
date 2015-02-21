json.array!(@products) do |product|
  json.extract! product, :id, :name, :desc, :category_id
  json.url product_url(product, format: :json)
end
