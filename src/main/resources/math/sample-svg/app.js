var app = angular.module('triangular', [
  'ngRoute',
  'firebase'
]);


app.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'main.html',
      controller: 'MainCtl'
    })
    .otherwise({
      redirectTo: '/'
    });
}); 




