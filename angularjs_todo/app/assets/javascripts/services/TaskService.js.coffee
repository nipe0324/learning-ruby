angular.module('todoApp').factory 'Task', ($resource, $http) ->
  class Task
    constructor: (taskListId) ->
      @service = $resource('/api/task_lists/:task_list_id/tasks/:id',
        { task_list_id: taskListId },
        { update: { method: 'PUT' }})

    create: (attrs) ->
      new @service(task: attrs).$save (task) ->
        attrs.id = task.id
      attrs

    delete: (task) ->
      new @service().$delete( { id: task.id } )

    update: (task, attrs) ->
      new @service(task: attrs).$update(id: task.id)

    all: ->
      @service.query()
