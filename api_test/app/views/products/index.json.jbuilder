json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :publised_at, :category_id
  json.url product_url(product, format: :json)
end
