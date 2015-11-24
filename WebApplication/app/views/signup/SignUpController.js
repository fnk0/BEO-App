/**
 * Created by marcus on 11/17/15.
 */

(function () {

    var app = angular.module('BEOApp');

    app.controller('SignUpController', ['$http', '$scope', '$filter', '$location', '$anchorScroll', '$routeParams', '$sce',
        function ($http, $scope, $filter, $location, $anchorScroll, $routeParams, $sce) {
            $.material.init();

            $scope.message = '';

            var usernameField = $("#username");
            var nameField = $("#name");
            var lastNameField = $("#lastName");
            var pwField = $("#password");
            var cpwField = $("#confirm_password");
            var phoneField = $("#phone_number");
            var isManager = $("#is_manager");

            $scope.submit = function() {

                var username = usernameField.val();
                var pw = pwField.val();
                var cpw = cpwField.val();

                if (pw.length >= 6) {
                    if (pw === cpw) {

                        var user = new Parse.User();
                        user.set("username", username);
                        user.set("password", pw);
                        user.set("email", username);
                        user.set("name", nameField.val());
                        user.set("lastName", lastNameField.val());
                        user.set("phone", phoneField.val());

                        var im = false;

                        if (isManager.val() == "on") {
                            im = true;
                        }

                        user.set("manager", im);

                        user.signUp(null, {
                            success: function(user) {
                                usernameField.val = "";
                                pwField.val = "";
                                cpwField.val = "";
                                $scope.message = "User with " + user.username + " successfully created";
                            },
                            error: function(user, error) {
                                $scope.message = "Error registering user: " + error.message;
                            }
                        });
                    } else {
                        $scope.message = "Passwords must match";
                    }
                } else {
                    $scope.message = "Password must be at least 6 characters"
                }
            }
        }]);
})();