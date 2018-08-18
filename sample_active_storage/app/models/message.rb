class Message < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  validates :images, file_size: { in: 100.kilobytes..1.megabyte },
                     file_content_type: { allow: ['image/jpeg', 'image/png'] }
end
