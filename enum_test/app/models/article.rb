class Article < ActiveRecord::Base
	# enumの定義(キーと数字のハッシュを渡す。数字がDBカラムに設定される)
  enum status: { draft: 0, published: 1 }
end
