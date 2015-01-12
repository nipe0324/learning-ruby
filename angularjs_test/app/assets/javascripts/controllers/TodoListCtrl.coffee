# コントローラーを定義する。今はこのように記載すると覚えておけば良い。
angular.module('sampleApp').controller "TodoListCtrl", ($scope, TodoList, Todo) ->

  # 初期データを用意するメソッド
  $scope.init = ->
    # Todoサービスクラスを作成
    # TODO todo_listのidを動的に取得する
    @todoListService = new TodoList(serverErrorHandler)
    @todoService     = new Todo(1, serverErrorHandler)
    # データを取得する(GET /api/todo_lists/:id => Api::TodoLists#show)
    $scope.list = @todoListService.find(1)


  $scope.addTodo = (todoDescription) ->
    # todoを追加する(POST /api/todo_lists/:todo_lsit_id/todos => Api::Todo#destroy)
    todo = @todoService.create(description: todoDescription, completed: false)
    # initメソッドで用意したtodosの一番最初にtodoを追加する
    $scope.list.todos.unshift(todo)
    # todo入力テキストフィールドを空にする
    $scope.todoDescription = ""


  # todoを削除するメソッド
  $scope.deleteTodo = (todo) ->
    # todoをサーバーから削除する(DELETE /api/todo_lists/todo_list_id/todos/:id => Api::Todo#destroy)
    @todoService.delete(todo)
    # todoをangularjsのlistデータから削除する(indexOfメソッドでtodoのindexを探し、spliceメソッドで削除する)
    $scope.list.todos.splice($scope.list.todos.indexOf(todo), 1)


  # todoの完了カラムをON/OFFするメソッド
  $scope.toggleTodo = (todo) ->
    @todoService.update(todo, completed: todo.completed)


  serverErrorHandler = ->
    alert("サーバーでエラーが発生しました。画面を更新し、もう一度試してください。")
