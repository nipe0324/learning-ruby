json.array!(@products) do |product|
  json.extract! product, :id, :name, :desc, :released_on
  json.url product_url(product, format: :json)
end
