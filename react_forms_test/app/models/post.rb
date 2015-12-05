# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  title       :string           not null
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Post < ActiveRecord::Base

  belongs_to :category
  has_many   :tags
  accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank

  validates :category_id, presence: true
  validates :tags,        presence: true
  validates :title,       presence: true
  validates :body,        presence: true
end
