'use strict';

app.controller('GameCtrl', ['$scope', 'gameSvc',
  function ($scope, gameSvc) {

    $scope.move = new Move();

    $scope.moves = gameSvc.getMoves();

    $scope.addMove = function () {
      gameSvc.addMove(angular.copy($scope.move));
      $scope.move = new Move();
    };

    $scope.updateMove = function (id) {
      gameSvc.updateMove(id);
    };

    $scope.removeMove = function (id) {
      gameSvc.removeMove(id);
    };
  }
]);