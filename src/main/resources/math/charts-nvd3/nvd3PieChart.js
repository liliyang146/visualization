// If there is more than one chart on a page, every chart should have a unique id.
$scope.id = "nvd3-pie-chart-"+uuid; 

$scope.pieData = [
  { key: 'Apple', y: 75 }, 
  { key: 'Oranges', y: 25 }
];

$scope.xFunction = function() {
  return function(d) {
      return d.key;
  };
};

$scope.yFunction = function() {
  return function(d){
    return d.y;
  };
};