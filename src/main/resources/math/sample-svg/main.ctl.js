app.controller('MainCtl', function($scope) {

  var WIDTH = 3;
  var HEIGHT = 2; 
  $scope.array20 = Array.apply(null, {length: WIDTH}).map(Number.call, Number)
  $scope.array5 = Array.apply(null, {length: HEIGHT}).map(Number.call, Number)
//  $scope.array20 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
//  $scope.array5 = [0,1,2,3,4];
  //$scope.total = 0;


  var getRandomInt = function(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
  
  var Question = function (theType, theText, theAnswer) {
    this.theType = theType;
    this.theText = theText;
	this.theAnswer = theAnswer;
  };
  
  var getRandomAddQuestion = function(max) {
    var finished = false;
	while (!finished) {
	  var op1 = getRandomInt(0,max);
	  var op2 = getRandomInt(0,max);
	  if (op1+op2 <= max) {
	    finished = true;
	  }
	}
	return new Question(1,""+op1+"+"+op2,op1+op2);
  }
	
  var getRandomSubQuestion = function(max) {
    var finished = false;
	while (!finished) {
	  var op1 = getRandomInt(0,max);
	  var op2 = getRandomInt(0,max);
	  if (op1-op2 >= 0) {
	    finished = true;
	  }
	}
	return new Question(2,""+op1+"-"+op2,op1-op2);
  }
  
  var getRandomMulQuestion = function(max) {
    var finished = false;
	while (!finished) {
	  var op1 = getRandomInt(0,max);
	  var op2 = getRandomInt(0,max);
	  if (op1*op2 <= max) {
	    finished = true;
	  }
	}
	return new Question(3,""+op1+"*"+op2,op1*op2);
  }

 var getRandomDivQuestion = function(max) {
    var finished = false;
	while (!finished) {
	  var op1 = getRandomInt(0,max);
	  var op2 = getRandomInt(1,max);
	  if (op1 % op2 == 0) {
	    finished = true;
	  }
	}
	return new Question(4,""+op1+"/"+op2,op1/op2);
  }


  var getRandomQuestion = function(max) {
    var theType = getRandomInt(1,4)
	if (theType == 1) {
	  return getRandomAddQuestion(max);
	} else if (theType == 2) {
	  return getRandomSubQuestion(max);
	} else if (theType == 3) {
	  return getRandomMulQuestion(max);
	} else {
	  return getRandomDivQuestion(max);
	} 
  };

  $scope.currentQuestion = getRandomQuestion(200);
 
  
  $scope.respStyles = new Array();
 
  $scope.myStyle = function(i,j) {
    if (WIDTH*i + j < $scope.respStyles.length) {
	  return $scope.respStyles[WIDTH*i + j];
	} else {
	  return "blank";
	}
  }
  
  $scope.colorClass = function(theType) {
    if (theType == 1) { return "forestgreen"; }
	if (theType == 2) { return "darkblue"; }
	if (theType == 3) { return "darkorange"; }
	if (theType == 4) { return "deeppink"; }
  }
  
  var isFirst = true;
  $scope.totalErrors = 0;
  $scope.result = true;
  
  $scope.checkResponse = function () {
    $scope.result = (+$scope.response == $scope.currentQuestion.theAnswer);
	if ($scope.result) {
	  if (isFirst) {
	    $scope.respStyles.push("content");
	  } else {
	    $scope.respStyles.push("wrong");
	  }
	  isFirst = true;
	} else {
	  //$scope.respStyles.push("wrong");
	  if (isFirst) {
	    $scope.totalErrors = $scope.totalErrors + 1;
	  }
	  isFirst = false;
	}
	
	$scope.currentQuestion = getRandomQuestion(200);
	$scope.response = "";
  };
  
  

   
});

