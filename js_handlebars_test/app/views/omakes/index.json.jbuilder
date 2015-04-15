json.array!(@omakes) do |omake|
  json.extract! omake, :id, :name, :price, :weight
  json.url omake_url(omake, format: :json)
end
