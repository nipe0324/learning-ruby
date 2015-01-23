json.id    @todo_list.id
json.name  @todo_list.name
json.todos @todo_list.todos.page(1) do |todo|
  json.id          todo.id
  json.description todo.description
  json.completed   todo.completed
end
json.totalTodos  @todo_list.todos.count