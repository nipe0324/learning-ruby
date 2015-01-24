class Todo < ActiveRecord::Base
  paginates_per 10

  belongs_to :todo_list
  acts_as_list scope: :todo_list, add_new_at: :top

  validates :todo_list_id, presence: true
  validates :description,  presence: true, length: { maximum: 255 }
  validates :completed, inclusion: { in: [true, false] }

  def target_position=(value)
    insert_at(value.to_i)
  end
end
