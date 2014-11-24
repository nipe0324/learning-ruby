class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks, dependent: :destroy

  validates :username, presence: true

  def self.new_guest
    new do |u|
      u.username = "Guest"
      u.email    = "guest_#{Time.now.to_i}#{rand(100)}@example.com"
      u.guest    = true
    end
  end

  def move_to(user)
    tasks.update_all(user_id: user.id)
  end
end
