json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :discontinued, :carrier_id
  json.url product_url(product, format: :json)
end
