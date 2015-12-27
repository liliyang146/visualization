'use strict';

app.controller('newGameCtrl', ['$scope', 'newGameSvc',
  function ($scope, newGameSvc) { 
    $scope.playerStyle = function(move,pos) {
      if (move.moveChanged == pos) {
        if (move.movePlayer == "A") {
	      return {"color":"blue", "font-weight":"bold"};
	    } else if (move.movePlayer == "B") {
		  return {"color":"red", "font-weight":"bold"};
	    } else { 
		  return {"color":"black"};
	    }
	  } else {
	    return {"color":"black"};
      }	
    };
       	
	this.moves = watchSource();
    $scope.moves = watchSource();
	$scope.theMove = new Move(-1,'',[0,0,0]);

	
	// have we reloaded after the refresh-from-DB was ordered
	this.loaded = true;
	
	$scope.description = newGameSvc.getDescription();	
	
    $scope.doesDataExist = function () {
      return (this.loaded && this.moves.length > 0);
    };
		
	
//	$scope.lastMove = new Move(-1,'',[0,0,0]);
		
	
	// When fresh moves are loaded
	$scope.$watch(watchSource, function(current, previous){
      this.moves = current;
	  $scope.moves = current;
	  this.loaded = true;
    });
  
    function watchSource(){	  
      return newGameSvc.getMoves();
    }  
	
	// Make sure that the next move is disabled until you load
	// a fresh copy from the database.
	/*
	$scope.refresh = function() {
	  $scope.moves = newGameSvc.getMoves();
	  $scope.moves.$loaded().then(function() {
	    $scope.lastMove = $scope.moves[($scope.moves).length - 1];
        $scope.theMove = angular.copy($scope.lastMove)
      });
	};
	
	$scope.refresh();
	*/
	
	$scope.addMove = function () {
      if ($scope.lastMove.movePlayer == 'A') {
	    $scope.theMove.movePlayer = 'B'; 
	  } else {
	    $scope.theMove.movePlayer = 'A'; 
	  }
      newGameSvc.addMove(angular.copy($scope.theMove));
	  this.loaded = false;
    };

	
	
	

	$scope.gameMessage = ""; 
	
	
    $scope.moveEnabled = -1;
   
    // This activates as you click in a new table cell
    $scope.moveEnable = function(pos) {
	  for (var i = 0; i < 3; i++) {
        if (pos != i) {
          $scope.theMove.num[i] = $scope.lastMove.num[i];
	    }
	  }
      $scope.moveEnabled = pos;
    };
   
    $scope.isDisabledField = function(pos) {
      return (($scope.moveEnabled == -1) || ($scope.moveEnabled != pos));
    };
   
    // TODO: Make that message text gradually disappearing (or display as alert)
	// TODO: Check non-numeric submissions or fractions or floating point numbers
    $scope.doSomething = function(pos) {
	  if ($scope.theMove.num[pos] >= $scope.lastMove.num[pos]) {
	    $scope.gameMessage = "Nederīgs gājiens: Skaitlis jāsamazina.";
	  } else if ($scope.theMove.num[pos] < 0) {
	    $scope.gameMessage = "Nederīgs gājiens: Skaitlis nevar būt negatīvs.";
	  } else {
//	    $scope.theMove.moveChanged = pos;
//		$scope.addMove();
		$scope.gameMessage = "";   
        newGameSvc.addMove(angular.copy($scope.theMove));		
	  }
    };
  }
]);