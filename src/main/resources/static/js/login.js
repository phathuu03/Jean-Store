var app = angular.module('myApp', []);

app.controller('LoginController', function ($scope, $http, $location) {

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
                        document.getElementById("username").value = response.data.khachHang.tenDangNhap
                        document.getElementById("password").value = response.data.khachHang.matKhau
                        document.getElementById("password").disabled = true;
                        document.getElementById("username").disabled = true;

                        document.getElementById("btnLogin").disabled = true;

                        document.getElementById("eyeIcon").hidden = true
                        document.getElementById("mess").hidden = true

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

})