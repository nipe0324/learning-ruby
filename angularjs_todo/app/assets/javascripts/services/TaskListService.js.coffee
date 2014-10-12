angular.module('todoApp').factory 'TaskList', ($resource, $http) ->
  class TaskList
    constructor: (taskListId, errorHandler) ->
      @service = $resource('/api/task_lists/:id',
        { id: '@id' },
        { update: { method: 'PUT' }})
      @errorHandler = errorHandler

    create: (successHandler) ->
      new @service().$save ((list) -> successHandler(list)), @errorHandler

    delete: (list) ->
      new @service().$delete { id: list.id }, (-> null), @errorHandler

    update: (list, attrs) ->
      new @service(list: attrs).$update {id: list.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)
