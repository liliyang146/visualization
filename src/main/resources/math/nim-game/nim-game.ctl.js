'use strict';

app.controller('nimGameCtrl', ['$scope', 'nimGameSvc',
  function ($scope, nimGameSvc) { 
    
   $scope.playerStyle = function(move,pos) {
    if (move.changed == pos) {
      if (move.player == "A") {
	    return {"color":"blue", "font-weight":"bold"};
	  } else if (move.player == "B") {
		return {"color":"red", "font-weight":"bold"};
	  } else { 
		return {"color":"black"};
	  }
	} else {
	  return {"color":"black"};
    }	
   };
   
   $scope.moveEnabled = 0;
   
   $scope.moveEnable = function(pos) {
      if (pos == 1) {
	     $scope.data2 = ""
		 $scope.data3 = ""
	  } else if (pos == 2) {
	     $scope.data1 = ""
		 $scope.data3 = ""
	  } else if (pos == 3) {
	     $scope.data1 = ""
		 $scope.data2 = ""
	  }
      $scope.moveEnabled = pos;
   };
   
   $scope.isDisabledField = function(pos) {
      return (($scope.moveEnabled == 0) || ($scope.moveEnabled != pos));
   };
   
   $scope.doSomething = function(pos) {
      $scope.moveEnabled = ($scope.postCodeData.result).length
	  /*
	  $scope.moveEnabled = 17;
	  
	  
	  var changed = 0;
	  if (pos == 1) {
	    changed = $scope.data1;
	  }
	  if (pos == 2) {
	    changed = $scope.data2;
	  }
	  if (pos == 3) {
	    changed = $scope.data3;
	  }
	  
	  if (!isNaN(parseFloat(changed)) && isFinite(changed)) {
	    var myArr = $scope.postCodeData.result;
	    var currentMove = myArr[myArr.length - 1];
	    if (currentMove.first > changed && changed >= 0) {
			$scope.moveEnabled = changed;
		} else {
		    $scope.moveEnabled = "Nederiigs skaitlis";
		}
		$scope.moveEnabled = "LENGTH=" + myArr.length;
	  } else {
        $scope.moveEnabled = "Nepareizs skaitlja formaats";
	  }
	  */
   };

   $scope.nimGameData = {};

    var success = function (data, status, headers, config) {
      $scope.nimGameData.result = data.result;
    };

    var error = function (data, status, headers, config) {
      $scope.nimGameData.error = data;
    };
	
    nimGameSvc.getNimGame(success, error);
  }
]);