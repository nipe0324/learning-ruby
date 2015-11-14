json.array!(@users) do |user|
  json.extract! user, :id, :name, :avator_url
  json.url user_url(user, format: :json)
end
