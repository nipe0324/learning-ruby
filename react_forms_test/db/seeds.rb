Category.delete_all
Post.delete_all
Tag.delete_all

Category.create!(name: "Cats")
Category.create!(name: "Politics")
Category.create!(name: "Spaceships")
Post.create!(
  category: Category.first,
  title: "I like cats",
  body: "Lorem dim sum",
  tags: [Tag.new(name: 'animal'), Tag.new(name: 'life')]
)
