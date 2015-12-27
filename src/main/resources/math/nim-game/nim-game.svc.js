'use strict';

app.service('nimGameSvc', ['$http', function ($http) {

  var getNimGame = function (success, error) {

    $http.get('http://www.dudajevagatve.lv/math/math/nim-game/todos.json')
      .success(function(data, status, headers, config) {
        success(data, status, headers, config);
      })
      .error(function(data, status, headers, config) {
        error(data, status, headers, config);
      });
  };

  this.getNimGame = getNimGame;
}]);
