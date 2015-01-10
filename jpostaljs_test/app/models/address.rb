class Address < ActiveRecord::Base
  belongs_to :prefecture

  def prefecture_name
    prefecture.try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture = Prefecture.find_by(name: prefecture_name)
  end
end
