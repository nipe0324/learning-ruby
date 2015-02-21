class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  include FriendlyId # extend FriendlyId でもよい(違いはない)
  friendly_id :name, use: [:slugged, :history]

  def normalize_friendly_id(value)
    value.to_s.parameterize.present? ? value.to_s.parameterize : value
  end

  def should_generate_new_friendly_id?
    name_changed?
  end
end
