json.array!(@categories) do |category|
  json.id     category.id.to_s
  json.text   category.name
  json.parent category.parent_id ? category.parent_id.to_s : '#'
  json.state do
    json.opened true
  end
end
