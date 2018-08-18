json.extract! message, :id, :user, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
