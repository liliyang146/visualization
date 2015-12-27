'use strict';

var app = angular.module('nimGameApp', [
  'ngRoute',
  'firebase'
]);

app.constant('FIREBASE_GAME', 'https://nim-game.firebaseio.com/');

app.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'newMoves.html',
      controller: 'newGameCtrl'
    })
	.when('/new', {
      templateUrl: 'newMoves.html',
      controller: 'newGameCtrl'	
	})
	.when('/reset', {
	  templateUrl: 'resetGame.html',
	  controller: 'resetGameCtrl'
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
