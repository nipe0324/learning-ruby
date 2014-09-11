var app = angular.module("Ahiru");

app.controller("ArticlesCtrl", [
  "$scope", "Article", function($scope, Article) {
    return $scope.articles = Article.query();
  }
]);