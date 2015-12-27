'use strict';

var app = angular.module('firebaseApp', [
  'ngRoute',
  'firebase'
]);

// this is the Firebase URL we'll be talking to
// in case of your Firebase account, please modify
// the below URL appropriately
app.constant('FIREBASE_URI', 'https://society.firebaseio.com/');

app.constant('FIREBASE_GAME', 'https://nim-game.firebaseio.com/');

app.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'main.html'
    })
    .when('/arrays', {
      templateUrl: 'sync-array/syncarray.tpl.html',
      controller: 'SyncArrayCtrl'
    })
    .when('/objects', {
      templateUrl: 'sync-object/object.tpl.html',
      controller: 'SyncObjectCtrl'
    })
    .when('/properties', {
      templateUrl: 'property/property.tpl.html',
      controller: 'PropertyCtrl'
    })
	.when('/game', {
	  templateUrl: 'game/game.tpl.html',
	  controller: 'GameCtrl'
	})
    .otherwise({
      redirectTo: '/'
    });
});
