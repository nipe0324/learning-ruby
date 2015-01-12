class TodoList < ActiveRecord::Base
  has_many :todos, -> { order "created_at DESC" }, dependent: :destroy

  validates :name, presence: true
end
