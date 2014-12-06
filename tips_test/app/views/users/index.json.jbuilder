json.array!(@users) do |user|
  json.extract! user, :id, :email, :password, :credit_card_number
  json.url user_url(user, format: :json)
end
