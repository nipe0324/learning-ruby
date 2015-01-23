angular.module('sampleApp').factory 'TodoList', ($resource, $http) ->
  class TodoList
    constructor: (errorHandler) ->
      @service = $resource('/api/todo_lists/:id',
        { id: '@id' },
        { update: { method: 'PUT' }})
      @errorHandler = errorHandler

    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id,((list)->
        successHandler?(list)
        list),
        @errorHandler)

    create: (attrs) ->
      new @service(todo_list: attrs).$save ((list) -> attrs.id = list.id), @errorHandler
      attrs

    update: (list, attrs) ->
      new @service(todo_list: attrs).$update {id: list.id}, (-> null), @errorHandler

    delete: (list) ->
      new @service().$delete { id: list.id }, (-> null), @errorHandler