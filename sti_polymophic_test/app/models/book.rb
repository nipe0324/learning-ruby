class Book < Product
  validates :author_id, presence: true

  def full_name
    "#{name} written by #{author.name}"
  end
end
