json.array!(@orders) do |order|
  json.extract! order, :id, :purchased_at
  json.url order_url(order, format: :json)
end
