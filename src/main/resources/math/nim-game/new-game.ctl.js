'use strict';

app.controller('newGameCtrl', ['$scope', '$timeout', 'newGameSvc',
  function ($scope, $timeout, newGameSvc) { 
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

       
    $scope.moves = watchSource();
	
	$scope.theMove = new Move(-1,'',[-1,-1,-1]);
	$scope.lastMove = new Move(-1,'',[-1,-1,-1]);
	
	$scope.description = newGameSvc.getDescription();	
	
	$scope.isLoaded = true;
	
    $scope.doesDataExist = function () {
      return $scope.moves.length > 0;
	  //return (($scope.isLoaded) && ($scope.moves.length > 0));
    };

    function watchSource(){	  
      return newGameSvc.getMoves('game2');
    }  

	
	$scope.gameOver = false;
	
	$scope.winner = "";
	
	$scope.getDateString = function() {
	  var now = new Date();
      //return now.format("yyyy-MM-dd hh:mm:ss TT");
	  return now.toLocaleString();
	}
	
	$scope.date1 = $scope.getDateString();
	
	$scope.isGameOver = function() {
	  return $scope.gameOver;
	}
	
	$scope.checkGameOver = function() {
	  $scope.date1 = $scope.getDateString();
	  if ((+$scope.theMove.num[0]) + 
	  (+$scope.theMove.num[1]) + 
	  (+$scope.theMove.num[2]) == 0) { 
//	  if ($scope.moves.length > 1 && 
//	      (+($scope.theMove.num[0])) == 0 &&
//	      (+($scope.theMove.num[1])) == 0 &&
//		  (+($scope.theMove.num[2])) == 0) {
		$scope.gameOver = true;
		$scope.winner = $scope.theMove.movePlayer;
	  } else {
	    //$scope.gameOver = false;
	  }
	};
	
	
	
	/*
	$scope.$watch(watchSource, function(current, previous){
      $scope.moves = current;
	  if (current.length > 0) {
	    $scope.lastMove = angular.copy(current[current.length - 1]);
	  } else {
	    $scope.lastMove = new Move(-1,'',[0,0,0]);
	  }
	  //$scope.isLoaded = true;
    });
	*/
	
		// Make sure that the next move is disabled until you load
	// a fresh copy from the database.
	
	$scope.refresh = function() {	  
	  $scope.moves = watchSource();
	  $scope.moves.$loaded().then(function() {
        $scope.lastMove = angular.copy($scope.moves[($scope.moves).length - 1]);
		$scope.theMove = angular.copy($scope.lastMove);
      });
	  $scope.checkGameOver();
	};
	
	$scope.refresh();
	
	$scope.addMove = function () {
      if ($scope.lastMove.movePlayer == 'A') {
	    $scope.theMove.movePlayer = 'B'; 
	  } else {
	    $scope.theMove.movePlayer = 'A'; 
	  }
      newGameSvc.addMove('game2',angular.copy($scope.theMove));
    };	

    $scope.moveEnabled = -1;	
	
	// This activates as you click in a new table cell
    $scope.moveEnable = function(pos) {
	  $scope.refresh();
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
	

	
    $scope.doSomething = function(pos) {
	  
	  if ($scope.theMove.num[pos] >= $scope.lastMove.num[pos]) {
	    $scope.gameMessage = "Nederīgs gājiens: Skaitlis jāsamazina.";
	  } else if ($scope.theMove.num[pos] < 0) {
	    $scope.gameMessage = "Nederīgs gājiens: Skaitlis nevar būt negatīvs.";
	  } else {
	    $scope.theMove.moveChanged = pos;
		$scope.gameMessage = "";   
		$scope.addMove();
		$timeout( function(){ 
		  $scope.refresh();		  
		}, 1000);
		
 	  }
    };

  }
]);