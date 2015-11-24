/**
 * Created by marcus on 11/17/15.
 */

(function () {

    var app = angular.module('BEOApp');

    app.controller('MainController', ['$http', '$scope', '$filter', '$location', '$rootScope', '$routeParams', '$sce',
        function ($http, $scope, $filter, $location, $rootScope, $routeParams, $sce) {
            $.material.init();

            $rootScope.signedIn = false;

            $scope.user = Parse.User.current();
            if ($scope.user) {
                console.log($scope.user);
            } else {
                $location.path("/");
            }

            $scope.goToBeo = function() {
                $location.path("/beo");
            };

            $scope.goToMenu = function() {
                $location.path("/menu");
            };

            $scope.goToTask = function() {
                $location.path("/task");
            };

        }]);
})();