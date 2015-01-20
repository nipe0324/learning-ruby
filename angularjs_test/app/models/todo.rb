class Todo < ActiveRecord::Base
  paginates_per 10

  belongs_to :todo_list

  validates :todo_list_id, presence: true
  validates :description,  presence: true, length: { maximum: 255 }
  validates :completed, inclusion: { in: [true, false] }
end
