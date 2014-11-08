json.array!(@shops) do |shop|
  json.extract! shop, :id, :name, :zipcode, :address, :tel
  json.url shop_url(shop, format: :json)
end
