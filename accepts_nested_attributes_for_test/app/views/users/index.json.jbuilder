json.array!(@users) do |user|
  json.extract! user, :id, :username, :age
  json.url user_url(user, format: :json)
end
