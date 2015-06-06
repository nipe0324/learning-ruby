(1..10).each do |n|
  List.create(name: "list #{n}")
end

(1..10).each do |n|
  Todo.create(name: "todo #{n}", position: n, list_id: 1)
end
