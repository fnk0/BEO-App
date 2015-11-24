/**
 * Created by marcus on 11/17/15.
 */

(function () {

    var app = angular.module('BEOApp');

    app.controller('TaskController', ['$http', '$scope', '$filter', '$location', '$rootScope', '$routeParams', '$sce',
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

            var employeeQuery = new Parse.Query(Parse.User);
            employeeQuery.equalTo("manager", false);  // find all the women
            employeeQuery.find({
                success: function(employees) {
                    $scope.employees = employees;
                }
            });


            var BEO = Parse.Object.extend("BEO");
            var beoQuery  = new Parse.Query(BEO);
            beoQuery.find({
                success: function(beos) {
                    $scope.beos = beos;
                }
            });

            $scope.submit = function() {

                var Task = Parse.Object.extend("Task");
                var task = new Task();

                task.set("manager", $scope.task.beo.get("manager"));
                task.set("employee", $scope.task.employee);
                task.set("completed", false);
                task.set("due", $scope.task.due);
                task.set("beo", $scope.task.beo);
                task.set("desc", $scope.task.desc);

                task.save(null, {
                    success: function(beo) {
                        $scope.message = 'New Task created with objectId: ' + beo.id;
                    },
                    error: function(beo, error) {
                        // Execute any logic that should take place if the save fails.
                        // error is a Parse.Error with an error code and message.
                        $scope.message = 'Failed to create new Task, with error code: ' + error.message;
                    }
                });

            };

        }]);
})();