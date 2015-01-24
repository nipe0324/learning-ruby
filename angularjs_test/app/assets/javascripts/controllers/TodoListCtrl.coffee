# コントローラーを定義する。今はこのように記載すると覚えておけば良い。
angular.module('sampleApp').controller "TodoListCtrl", ($scope, $routeParams, TodoList, Todo) ->

  # 初期データを用意するメソッド
  $scope.init = ->
    # Todoサービスクラスを作成
    @todoListService = new TodoList(serverErrorHandler)
    @todoService     = new Todo($routeParams.list_id, serverErrorHandler)
    # データを取得する(GET /api/todo_lists/:id => Api::TodoLists#show)
    $scope.list = @todoListService.find($routeParams.list_id, (res)-> $scope.totalTodos = res.totalTodos)

    # 画面表示時はundefinedのため初期値を設定しておく
    $scope.descriptionCont = ""
    $scope.completedTrue   = ""

  $scope.search = ->
    # Ransackに対応したparamsを送る
    params = {
      'q[description_cont]' : $scope.descriptionCont,
      'q[completed_true]'   : $scope.completedTrue,
      'page'                : $scope.currentPage
    }
    $scope.list = @todoService.all(params, (res)-> $scope.totalTodos = res.totalTodos)

  $scope.addTodo = (todoDescription) ->
    raisePositions($scope.list)
    todo = @todoService.create(description: todoDescription, completed: false)
    todo.position = 1
    $scope.list.todos.unshift(todo)
    $scope.todoDescription = ""


  $scope.deleteTodo = (todo) ->
    lowerPositionsBelow($scope.list, todo)
    @todoService.delete(todo)
    $scope.list.todos.splice($scope.list.todos.indexOf(todo), 1)


  # todoの完了カラムをON/OFFするメソッド
  $scope.toggleTodo = (todo) ->
    @todoService.update(todo, completed: todo.completed)


  $scope.listNameEdited = (listName) ->
    @todoListService.update($scope.list, name: listName)

  $scope.todoDescriptionEdited = (todo) ->
    @todoService.update(todo, description: todo.description)

  $scope.positionChanged = (todo) ->
    @todoService.update(todo, target_position: todo.position)
    updatePositions($scope.list)

  $scope.sortListeners = {
    accept: (sourceItemHandleScope, destSortableScope) ->
      return true

    orderChanged: (event) ->
      newPosition   = event.dest.index + 1
      todo          = event.source.itemScope.modelValue
      todo.position = newPosition
      $scope.positionChanged(todo)
  }

  serverErrorHandler = ->
    alert("サーバーでエラーが発生しました。画面を更新し、もう一度試してください。")

  raisePositions = (list) ->
    angular.forEach list.todos, (todo) ->
      todo.position += 1

  lowerPositionsBelow = (list, todo) ->
    angular.forEach todosBelow(list, todo), (todo) ->
      todo.position -= 1

  todosBelow = (list, todo) ->
    list.todos.slice(list.todos.indexOf(todo), list.todos.length)

  updatePositions = (list) ->
    angular.forEach list.todos, (todo, index) ->
      todo.position = index + 1
