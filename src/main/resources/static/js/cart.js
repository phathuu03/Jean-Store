var app = angular.module('myApp', []);

app.controller('CartController', function ($scope,$http) {
    $scope.cart = JSON.parse(localStorage.getItem('cart')) || [];

    $scope.updateTotalPrice = function () {
        $scope.sumPriceCart = $scope.cart.reduce((total, item) => total + item.quantity * item.price, 0);
    };

    $scope.decreaseQuantityCart = function (item) {
        if (item.quantity > 1) {
            item.quantity--;
        }
        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.updateTotalPrice();
    };
    $scope.increaseQuantityCart = function (item) {
        if (item.quantity < item.quantityReal) {
            item.quantity++;
        }
        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.updateTotalPrice();
    };
    $scope.removeFromCart = function (id) {
        $scope.cart = $scope.cart.filter(item => item.idProductDetail !== id);
        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.updateTotalPrice();
    };

    $scope.updateTotalPrice();
    $scope.idUser = null;



});