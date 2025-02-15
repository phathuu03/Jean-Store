var app = angular.module('myApp', []);

app.controller('OrderController', function ($scope, $http) {
    $scope.cart = JSON.parse(localStorage.getItem('cart')) || [];
    $scope.sumPriceCart = $scope.cart.reduce((total, item) => total + item.quantity * item.price, 0);
    console.log(localStorage.getItem('cart'))

    // Lấy ID người dùng
    $scope.idUser = null;
    $scope.user = null;

    $scope.getAchat = function () {
        const urlGetIdUser = `http://localhost:8080/user/id`;

        return $http.get(urlGetIdUser)
            .then(function (response) {
                if (response.data.id) {
                    $scope.idUser = response.data.id;
                    console.log("ID User:", $scope.idUser);
                    return $scope.idUser; // Trả về ID để gọi API tiếp theo
                } else {
                    throw new Error("Không tìm thấy ID User");
                }
            })
            .catch(function (error) {
                console.error("Lỗi khi lấy ID user:", error);
            });
    };

    // Lấy thông tin user bằng ID
    $scope.getUser = function () {
        $scope.getAchat().then(function (idUser) {
            if (!idUser) return;

            const urlGetUser = `http://localhost:8080/user?id=${idUser}`;

            return $http.get(urlGetUser)
                .then(function (response) {
                    if (response.data.khachHang) {
                        $scope.user = response.data.khachHang;
                        console.log("Thông tin user:", $scope.user);
                    } else {
                        console.warn("Không tìm thấy khách hàng với ID:", idUser);
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi khi lấy thông tin user:", error);
                });
        });
    };
    $scope.getUser();
    $scope.voucher = null;
    $scope.getVoucher = function () {
        const url = `http://localhost:8080/order?dieuKien=${$scope.sumPriceCart}`;

        $http.get(url).then(function (response) {
            if (response.data.voucher != undefined){
                $scope.voucher = response.data.voucher
                $scope.voucher.forEach(
                    item=> console.log("voucher" + item.id)
                )

            }
        })
    }
    $scope.moneyAfterDiscount = $scope.sumPriceCart;
    $scope.setMoney = function (discountMax,percent) {
        $scope.moneyAfterDiscount = $scope.sumPriceCart;
        $scope.moneyIsReduced = ($scope.moneyAfterDiscount * percent) / 100
        console.log("money" + $scope.moneyIsReduced)
        if ($scope.moneyIsReduced > discountMax){
            $scope.moneyIsReduced = discountMax
            $scope.moneyAfterDiscount = $scope.moneyAfterDiscount - discountMax
        }else{
            $scope.moneyAfterDiscount = $scope.moneyAfterDiscount - $scope.moneyIsReduced
        }
    }
    $scope.getVoucher();
});
