'use strict';

(function () {

    var app = angular.module('BEOApp', ['ngRoute']);

    Parse.initialize("47TvyUq7DP4QegaQgV1fHXRx6yGO86T483CMP4xh", "BZZ3iNS0cQzzo7ZcjsNhy7a99hZQfJ9zk3DqTDyl");

    app.config(function ($httpProvider, $routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/sign_in/sign_in.html',
                controller: 'SignInController'
            })
            .when('/signup', {
                templateUrl: 'views/signup/sign_up.html',
                controller: 'SignUpController'
            })
            .when('/main', {
                templateUrl: 'views/main/main.html',
                controller: 'MainController'
            })
            .when('/beo', {
                templateUrl: 'views/beo/beo.html',
                controller: 'BeoController'
            })
            .when('/menu', {
                templateUrl: 'views/menu/menu.html',
                controller: 'MenuController'
            })
            .when('/task', {
                templateUrl: 'views/task/task.html',
                controller: 'TaskController'
            })
            .otherwise({
                redirectTo: '/'
            });
    });

    app.controller('AppController', function ($scope, $location, $anchorScroll, $routeParams) {

        $scope.signedIn = Parse.User.current();
        $scope.signOut = function () {
            Parse.User.logOut();
            $location.path("/");
        }

    });

    app.filter("sanitize", ['$sce', function ($sce) {
        return function (htmlCode) {
            return $sce.trustAsHtml(htmlCode);
        }
    }]);

})();