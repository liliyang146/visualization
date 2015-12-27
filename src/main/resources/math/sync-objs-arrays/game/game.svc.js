'use strict';

app.factory('gameSvc', ['FIREBASE_GAME', '$firebaseArray',
  function (FIREBASE_GAME, $firebaseArray) {
    var movesUri = FIREBASE_GAME + '/moves';
    var ref = new Firebase(movesUri);
    var moves = $firebaseArray(ref);

    var getMoves = function () {
      return moves;
    };

    var addMove = function (item) {
      moves.$add(item);
    };

    var updateMove = function (id) {
      moves.$save(id);
    };

    var removeMove = function (id) {
      moves.$remove(id);
    };

    return {
      getMoves: getMoves,
      addMove: addMove,
      updateMove: updateMove,
      removeMove: removeMove
    }
  }]);