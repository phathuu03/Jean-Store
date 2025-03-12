var app = angular.module('myApp', []);

app.controller('HomeController', function ($scope, $http) {
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
                            document.getElementById("textWelcome").innerText = "Welcome:" + $scope.user.tenDangNhap;
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

    }
)