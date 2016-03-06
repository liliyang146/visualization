'use strict';

var app = angular.module('nimGameApp', [
  'ngRoute',
  'firebase'
]);

app.constant('FIREBASE_GAME', 'https://nim-game.firebaseio.com/');

app.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'moves.html',
      controller: 'nimGameCtrl'
    })
	.when('/new', {
      templateUrl: 'newMoves.html',
      controller: 'newGameCtrl'	
	})
    .otherwise({
      redirectTo: '/'
    });
});

app.directive('myEnter', function () {
    return function (scope, element, attrs) {
        element.bind("keydown keypress", function (event) {
            if (event.which === 13) {
                scope.$apply(function (){
                    scope.$eval(attrs.myEnter);
                });
                event.preventDefault();
            }
        });
    };
});
