/**
 * Created by marcus on 11/17/15.
 */

(function () {

    var app = angular.module('BEOApp');

    app.controller('MenuController', ['$http', '$scope', '$filter', '$location', '$rootScope', '$routeParams', '$sce',
        function ($http, $scope, $filter, $location, $rootScope, $routeParams, $sce) {
            //$.material.init();

            $rootScope.signedIn = false;

            $scope.user = Parse.User.current();
            if ($scope.user) {
                console.log($scope.user);
            } else {
                $location.path("/");
            }

            $scope.options = [
                "Breakfast",
                "Lunch",
                "Dinner"
            ];

            var Menu = Parse.Object.extend("Menu");

            $scope.menu = {};
            $scope.menu.typeOfFood = $scope.options[0];

            $scope.submit = function() {
                var pMenu = new Menu();
                pMenu.set("appetizer", $scope.menu.appetizer);
                pMenu.set("entre", $scope.menu.entre);
                pMenu.set("dessert", $scope.menu.dessert);
                pMenu.set("typeOfFood", $scope.menu.typeOfFood);
                pMenu.save(null, {
                    success: function(menu) {
                        $scope.message = 'New menu created with objectId: ' + menu.id;
                    },
                    error: function(menu, error) {
                        // Execute any logic that should take place if the save fails.
                        // error is a Parse.Error with an error code and message.
                        $scope.message = 'Failed to create new object, with error code: ' + error.message;
                    }
                });

            }

        }]);
})();