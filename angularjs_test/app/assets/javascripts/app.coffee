# AngularJSの設定ファイル
# 依存ライブラリを記述する
app = angular.module('sampleApp', ['ui.bootstrap', 'ngResource', 'ngRoute', 'mk.editablespan'])

# CSRFのトークンを設定するようにする
app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

# ルートの設定
app.config ($routeProvider, $locationProvider) ->
  # html5モードを有効にする
  $locationProvider.html5Mode true
  # / にアクセスすると、 /dashboard にリダイレクトする
  $routeProvider.when '/',                    redirectTo:  '/dashboard'
  # /dashboard にアクセスすると、 /templates/dashboard.html を表示する（合わせてDashboardCtrlを読み込む)
  $routeProvider.when '/dashboard',           templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl'
  # /dashboard にアクセスすると、 /templates/task_list.html を表示する（合わせてTodoListCtrlを読み込む)
  $routeProvider.when '/todo_lists/:list_id', templateUrl: '/templates/todo_list.html', controller: 'TodoListCtrl'

# AngularJSがturbolinksと一緒に動くようにする
$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
