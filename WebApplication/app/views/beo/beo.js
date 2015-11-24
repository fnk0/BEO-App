/**
 * Created by marcus on 11/17/15.
 */

(function () {

    var app = angular.module('BEOApp');

    app.controller('BeoController', ['$http', '$scope', '$filter', '$location', '$rootScope', '$routeParams', '$sce',
        function ($http, $scope, $filter, $location, $rootScope, $routeParams, $sce) {
            //$.material.init();

            $rootScope.signedIn = false;

            $scope.user = Parse.User.current();
            if ($scope.user) {
                console.log($scope.user);
            } else {
                $location.path("/");
            }

            $scope.dinnerStyles = [
                "Formal Dinner Style",
                "Casual Dinner Style",
                "Wedding Set"
            ];

            $scope.beo = {};

            var managerQuery = new Parse.Query(Parse.User);
            managerQuery.equalTo("manager", true);  // find all the women
            managerQuery.find({
                success: function(managers) {
                    $scope.managers = managers;
                }
            });

            var Menu = Parse.Object.extend("Menu");
            var menuQuery  = new Parse.Query(Menu);
            menuQuery.find({
                success: function(menus) {
                    $scope.menus = menus;
                }
            });

            $scope.getManagerName = function(manager) {
                return manager.get("name") + " " + manager.get("lastName");
            };

            $scope.submit = function() {

                var BEO = Parse.Object.extend("BEO");
                var beo = new BEO();

                beo.set("manager", $scope.beo.manager);
                beo.set("title", $scope.beo.title);
                beo.set("expecting", $scope.beo.expecting);
                beo.set("rsvp", $scope.beo.rsvp);
                beo.set("date", $scope.beo.date);
                beo.set("due", $scope.beo.due);
                beo.set("timePeriod", $scope.beo.timePeriod);
                beo.set("notes", $scope.beo.notes);
                beo.set("dinnerStyle", $scope.beo.dinnerStyle);
                beo.set("menu", $scope.beo.menu);
                beo.set("clean", $scope.beo.clean);
                beo.save(null, {
                    success: function(beo) {
                        $scope.message = 'New BEO created with objectId: ' + beo.id;
                        $location.path("/beo");
                    },
                    error: function(beo, error) {
                        // Execute any logic that should take place if the save fails.
                        // error is a Parse.Error with an error code and message.
                        $scope.message = 'Failed to create new BEO, with error code: ' + error.message;
                    }
                });

            };

        }]);
})();