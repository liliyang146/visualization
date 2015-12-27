'use strict';

app.service('newGameSvc', ['FIREBASE_GAME', '$firebaseArray', '$firebaseObject',
  function (FIREBASE_GAME , $firebaseArray, $firebaseObject
  ) {

  var nimUri = FIREBASE_GAME + 'nim';
  var ref = new Firebase(nimUri);
  var description = $firebaseObject(ref.child('description'));

  var getDescription = function() {
    return description;
  };

  //var moves = $firebaseArray(ref.child('games').child('game2').child('moves'));

  var getMoves = function (gg) {
    var moves = $firebaseArray(ref.child('games').child(gg).child('moves'));
    return moves;
  };	
  
  var addMove = function (gg,item) {
    var moves = getMoves(gg);
    moves.$add(item);
  };

  return {
    getMoves: getMoves, 
	getDescription: getDescription,
	addMove: addMove
  }

  
}]);



