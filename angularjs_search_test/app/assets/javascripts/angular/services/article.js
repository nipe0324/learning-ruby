var app = angular.module("Ahiru");

app.factory("Article", function($resource) {
  return $resource("/api/articles/:id", {id: "@id"});
});