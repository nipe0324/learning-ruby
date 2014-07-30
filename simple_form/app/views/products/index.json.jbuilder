json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :released_on, :rating, :discontinued, :publisher_id
  json.url product_url(product, format: :json)
end
