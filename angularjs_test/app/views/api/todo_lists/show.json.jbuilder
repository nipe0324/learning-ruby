json.name  @todo_list.name
json.todos @todo_list.todos do |todo|
  json.id          todo.id
  json.description todo.description
  json.completed   todo.completed
end
