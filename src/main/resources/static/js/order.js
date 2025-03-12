var app = angular.module('myApp', []);

app.controller('OrderController', function ($scope, $http) {
    $scope.cart = JSON.parse(sessionStorage.getItem('cart')) || [];
    $scope.sumPriceCart = $scope.cart.reduce((total, item) => total + item.quantity * item.price, 0);
    console.log(sessionStorage.getItem('cart'))

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
                        $scope.setButtonLogin($scope.idUser);
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


    $scope.setButtonLogin = function (idUser) {
        if (idUser != null) {

            const urlGetUser = `http://localhost:8080/user?id=${idUser}`;
            $http.get(urlGetUser)
                .then(function (response) {
                    if (response.data.khachHang) {
                        $scope.user = response.data.khachHang;
                        document.getElementById("btnLogin").style.display = "none";
                        document.getElementById("textWelcome").style.display = "block";
                        document.getElementById("textWelcome").innerText = "Welcome : " + $scope.user.tenDangNhap;
                        console.log("Thông tin user:", $scope.user);
                    } else {
                        console.warn("Không tìm thấy khách hàng với ID:", idUser);
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi khi lấy thông tin user:", error);
                });
        }
    }
    $scope.voucher = null;
    $scope.getVoucher = function () {
        const url = `http://localhost:8080/order?dieuKien=${$scope.sumPriceCart}`;

        $http.get(url).then(function (response) {
            if (response.data.voucher != undefined) {
                $scope.voucher = response.data.voucher
                $scope.voucher.forEach(
                    item => console.log("voucher" + item.id)
                )
            }
        })
    }
    $scope.moneyAfterDiscount = $scope.sumPriceCart;
    $scope.selectedVoucher = null;
    $scope.idVoucher = null;
    $scope.setMoney = function (discountMax, percent) {
        $scope.moneyAfterDiscount = $scope.sumPriceCart;
        $scope.moneyIsReduced = ($scope.moneyAfterDiscount * percent) / 100
        console.log("money" + $scope.moneyIsReduced)
        if ($scope.moneyIsReduced > discountMax) {
            $scope.moneyIsReduced = discountMax
            $scope.moneyAfterDiscount = $scope.moneyAfterDiscount - discountMax
        } else {
            $scope.moneyAfterDiscount = $scope.moneyAfterDiscount - $scope.moneyIsReduced
        }
        $scope.idVoucher = $scope.selectedVoucher.id;
    }
    $scope.getVoucher();
    $scope.urlPayment = null;

    $scope.idPTTT = null
    $scope.selectedPaymentMethod = null;
    $scope.onPaymentMethodChange = function () {
        $scope.idPTTT = $scope.selectedPaymentMethod;
    }
    $scope.idHoaDon = null;
    $scope.checkout = function () {
        if ($scope.idPTTT == null) {
            alert("Vui lòng chọn phương thức thanh toán !")
            return;
        }
        $scope.diaChi = document.getElementById("address").innerText
        if ($scope.idPTTT == 1) {
            if ($scope.idVoucher == null) {
                var urlInsert = `http://localhost:8080/insert-bill/isnull?sumMoney=${$scope.moneyAfterDiscount}&address=${$scope.diaChi}&idUser=${$scope.idUser}&idPTTT=${$scope.idPTTT}`;
            } else {
                var urlInsert = `http://localhost:8080/insert-bill?sumMoney=${$scope.moneyAfterDiscount}&address=${$scope.user.diaChi}&idUser=${$scope.idUser}&idVoucher=${$scope.idVoucher}&idPTTT=${$scope.idPTTT}`;
            }
            $http.post(urlInsert).then(function (response) {
                    if (response.status == 200) {
                        $scope.idHoaDon = response.data
                    }
                    $scope.cart.forEach(
                        item => {
                            const url = `http://localhost:8080/insert-billDetail?quantity=${item.quantity}&price=${item.price}&sumMoney=${item.quantity * item.price}&idHoaDon=${$scope.idHoaDon}&idQuanCT=${item.idProductDetail}`;
                            $http.post(url).then(function (response) {

                                }
                            )
                        }
                    )
                }
            ).then(function () {
                alert("Đặt hàng thành công !")
                sessionStorage.clear();
                window.location.href = "/order-history";

                const urlDeleteCard = `http://localhost:8080/delete/cart?id=${$scope.idUser}`;

                $http.delete(urlDeleteCard).then(function (response) {
                    if (response.status == 200) {
                        console.log("deleteCard Ok")
                    }
                }).catch(function (error) {
                    console.error("error delete :", error)
                })
            }).catch(function (error) {
                console.error("Lỗi : ", error)
                alert("Đặt hàng thất bại !")
            })
        }
    }
});
