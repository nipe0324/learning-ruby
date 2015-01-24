json.name @todo_list.name
json.todos @todos do |todo|
  json.id          todo.id
  json.description todo.description
  json.completed   todo.completed
  json.position    todo.position
end
json.totalTodos  @total_todos