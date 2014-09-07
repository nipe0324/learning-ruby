# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

literature = Category.create! name: "文学"
history = Category.create! name: "歴史"
business = Category.create! name: "ビジネス"
science = Category.create! name: "科学"
comic = Category.create! name: "コミック"

suzuki = Publisher.create! name: "鈴木書店"
tanaka = Publisher.create! name: "田中出版"
shugo = Publisher.create! name: "集合社"
otona = Publisher.create! name: "大人館"