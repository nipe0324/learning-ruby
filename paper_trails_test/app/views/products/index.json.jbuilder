json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :public
  json.url product_url(product, format: :json)
end
