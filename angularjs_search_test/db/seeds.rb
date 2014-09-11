# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


title_names = %w(perl ruby python php java) * 6

0..29.times do |idx|
  Article.create!(
   title: title_names[idx],
   content: "避暑地・鎌倉を訪れた大学生の「私」は、由比が浜で見かけた「先生」に興味を持ちます。\n
             言葉を交わすようになりましたが、「先生」の態度はそっけないものでした。回想の物語で \n"
  )
end