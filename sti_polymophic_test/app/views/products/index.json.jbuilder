json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :maker_id, :cpu_id, :author_id
  json.url product_url(product, format: :json)
end
