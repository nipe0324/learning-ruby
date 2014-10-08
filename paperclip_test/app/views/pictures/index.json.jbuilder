json.array!(@pictures) do |picture|
  json.extract! picture, :id, :name
  json.url picture_url(picture, format: :json)
end
