class Address < ActiveRecord::Base
  belongs_to :user

  validates :zipcode, presence: true
  validates :city,    presence: true
end
