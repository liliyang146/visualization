'use strict';

app.service('postCodeSvc', ['$http', function ($http) {

  var getRandomPostCode = function (success, error) {

    $http.get('http://www.dudajevagatve.lv/math/math/another-game/todos.json')
// $http.get('http://api.postcodes.io/random/postcodes')
      .success(function(data, status, headers, config) {
        success(data, status, headers, config);
      })
      .error(function(data, status, headers, config) {
        error(data, status, headers, config);
      });
  };

  this.getRandomPostCode = getRandomPostCode;
}]);
