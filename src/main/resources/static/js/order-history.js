var app = angular.module('orderApp', []);
app.controller('OrderDetailController', function ($scope, $http) {

    $scope.imageUrls = {};

    $scope.getImage = function (colorId, productId, hdctId) {
        const url = `http://localhost:8080/home/product-detail/color?colorId=${colorId}&productId=${productId}`;

        $http.get(url).then(function (response) {
            if (response.data) {
                $scope.imageUrls[hdctId] = response.data.imageUrl;
            }
        });
    };

    $scope.loadImages = function () {
        document.querySelectorAll('.order-item').forEach(item => {
            const colorId = item.getAttribute("data-color-id");
            const productId = item.getAttribute("data-product-id");
            const hdctId = item.getAttribute("data-hdct-id");
            $scope.getImage(colorId, productId, hdctId);
        });
    };
    $scope.idUser = null;

    $scope.getUser = function () {
        const urlGetIdUser = `http://localhost:8080/user/id`;
        $http.get(urlGetIdUser)
            .then(function (response) {
                if (response.data.id) {
                    $scope.idUser = response.data.id;
                    $scope.setButtonLogin($scope.idUser);
                    console.log("ID User:", $scope.idUser);
                } else {
                    throw new Error("Không tìm thấy ID User");
                }
            })
            .catch(function (error) {
                console.error("Lỗi khi lấy ID user:", error);
            });
    };
    $scope.getUser()


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

    $scope.loadImages();

    $scope.setTTHuy = function () {
        $scope.reason = document.getElementById("textReason").value

        const url = `http://localhost:8080/update/tt-huy?id=${$scope.id}&ghiChu=${$scope.reason}`;

        let isConfirmed = confirm("Bạn có muốn hủy không?");

        if (!isConfirmed) {
            return;
        }
        $http.put(url).then(function (response) {
            if (response.status == 200) {
                location.reload()
                alert("Đã hủy thành công");
            }
        })
    }
    $scope.id = null;

    $scope.getId = function (id) {
        $scope.id = id
    }

    $scope.setTTHoanThanh = function (id) {
        const url = `http://localhost:8080/update/tt-hoanthanh?id=${id}`;

        let isConfirmed = confirm("Bạn chắc chắn đã nhận được hàng ?");

        if (!isConfirmed) {
            return;
        }
        $http.put(url).then(function (response) {
            if (response.status == 200) {
                location.reload()
            }
        })
    }
});
