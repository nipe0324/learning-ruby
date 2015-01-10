json.array!(@addresses) do |address|
  json.extract! address, :id, :zipcode, :prefecture_id, :city, :street, :building
  json.url address_url(address, format: :json)
end
