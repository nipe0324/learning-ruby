angular.module('sampleApp').controller "DashboardCtrl", ($scope, TodoList) ->

  $scope.init = ->
    @listsService = new TodoList(serverErrorHandler)
    $scope.lists = @listsService.all()

  $scope.createList = (listName) ->
    list = @listsService.create(name: listName)
    $scope.lists.push(list)
    $scope.listName = ""

  $scope.deleteList = (list, index) ->
    if confirm "リストを削除しますか?"
      @listsService.delete(list)
      $scope.lists.splice(index, 1)

  serverErrorHandler = ->
    alert("サーバーでエラーが発生しました。画面を更新し、もう一度試してください。")
