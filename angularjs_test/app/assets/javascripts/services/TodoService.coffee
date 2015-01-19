angular.module('sampleApp').factory 'Todo', ($resource, $http) ->
  class Todo
    constructor: (todoListId, errorHandler) ->
      @service = $resource('/api/todo_lists/:todo_list_id/todos/:id',
        { todo_list_id: todoListId },
        { update: { method: 'PUT' }})
      @errorHandler = errorHandler

    all: (params)->
      @service.query(params, (-> null), @errorHandler)

    create: (attrs) ->
      new @service(todo: attrs).$save ((todo) -> attrs.id = todo.id), @errorHandler
      attrs

    delete: (todo) ->
      new @service().$delete { id: todo.id }, (-> null), @errorHandler

    update: (todo, attrs) ->
      new @service(todo: attrs).$update {id: todo.id}, (-> null), @errorHandler
