# コントローラーを定義する。今はこのように記載すると覚えておけば良い。
angular.module('sampleApp').controller "TodoListCtrl", ($scope) ->

  # 初期データを用意するメソッド
  $scope.init = ->
    $scope.list = {
      'name'  : 'Todoリスト1',
      'tasks' : [
        { 'description' : 'task description1', 'completed' : false },
        { 'description' : 'task description2', 'completed' : false }
      ]
    }

  $scope.addTask = (taskDescription) ->
    # taskを作成する
    task = { 'description' : taskDescription, 'completed' : false }
    # initメソッドで用意したtasksの一番最初に作成したtaskを追加する
    $scope.list.tasks.unshift(task)
    # タスク入力欄を空にする
    $scope.taskDescription = ""

  $scope.deleteTask = (task) ->
    # indexOfメソッドでtaskのindexを探し、spliceメソッドで削除する
    $scope.list.tasks.splice($scope.list.tasks.indexOf(task), 1)
