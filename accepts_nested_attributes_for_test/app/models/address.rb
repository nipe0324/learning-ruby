class Address < ActiveRecord::Base
  belongs_to :user

  validates :zipcode,  presence: true
  validates :city,     presence: true
  validates :street,   presence: true
  validates :tel,      presence: true
end
