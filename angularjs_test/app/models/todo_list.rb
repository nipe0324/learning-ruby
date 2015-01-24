class TodoList < ActiveRecord::Base
  has_many :todos, -> { order "position" }, dependent: :destroy

  validates :name, presence: true
end
