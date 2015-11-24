/**
 * Created by marcus on 11/17/15.
 */

(function () {

    var app = angular.module('BEOApp');

    app.controller('SignInController', ['$http', '$scope', '$filter', '$location', '$rootScope', '$routeParams', '$sce',
        function ($http, $scope, $filter, $location, $rootScope, $routeParams, $sce) {
            $.material.init();

            var currentUser = Parse.User.current();
            if (currentUser) {
                $location.path("/main");
            }

            $rootScope.signedIn = false;
            $scope.message = '';

            var usernameField = $("#username");
            var pwField = $("#password");

            $scope.submit = function () {

                var username = usernameField.val();
                var pw = pwField.val();

                if (pw.length >= 6) {
                    Parse.User.logIn(username, pw, {
                        success: function(user) {
                            $location.path("/main");
                            console.log("success!.. logged in as " + user.getUsername());
                        },
                        error: function(user, error) {
                            // The login failed. Check error to see why.
                            $scope.message = "Username or Password incorrect"
                        }
                    });
                } else {
                    $scope.message = "Password must be at least 6 characters"
                }
            }
        }]);
})();