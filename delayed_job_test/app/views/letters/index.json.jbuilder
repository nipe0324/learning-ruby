json.array!(@letters) do |letter|
  json.extract! letter, :id, :title, :description, :delivered_at
  json.url letter_url(letter, format: :json)
end
