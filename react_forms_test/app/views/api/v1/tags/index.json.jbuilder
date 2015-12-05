json.tags(@tags) do |tag|
  json.partial!(tag)
end
