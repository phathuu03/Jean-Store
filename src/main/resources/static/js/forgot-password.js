var app = angular.module('myApp', []);

app.controller('ForgotController', function ($scope, $http) {
    $scope.sendEmail = function () {
        $scope.email = document.getElementById("email").value
        $scope.username = document.getElementById("username").value

        console.log($scope.email)
        console.log($scope.username)

        const url = `http://localhost:8080/send-email?email=${$scope.email}&username=${$scope.username}`;
        $http.get(url).then(
            function (response) {
                if (response.data.code == 100) {
                    alert("Vui lòng check email");
                } else {
                    alert("Không tìm thấy user name cùng email này");
                }
            }
        ).catch(function (error) {
            console.log(error);
            alert("Gửi thất bại");
        })

    }
    $scope.changePassword = function () {
        $scope.newPassword = document.getElementById("newPassword").value
        $scope.confirmPassword = document.getElementById("confirmPassword").value

        let regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.#$!%*?&])[A-Za-z\d@.#$!%*?&]{8,15}$/;
        let checkRegex = regex.test($scope.newPassword)

        $scope.check = {
            passwordNew: false,
            passwordConfirm: false
        }

        $scope.mes = {
            passwordNew: "",
            passwordConfirm: ""
        }

        if ($scope.newPassword == null || $scope.newPassword === "") {
            $scope.mes.passwordNew = "Không được để trống";
            $scope.check.passwordNew = true
            return;
        }
        if ($scope.confirmPassword == null || $scope.confirmPassword === "") {
            $scope.mes.passwordConfirm = "Không được để trống";
            $scope.check.passwordConfirm = true
            return;
        }
        if (!checkRegex) {
            $scope.mes.passwordNew = "Mật khẩu phải chứa ít nhất một chữ in hoa,một chữ in thường, một chữ số và một ký tự đặc biệt.(Độ dài 8 - 15 ký tự.)";
            $scope.check.passwordNew = true;
            return;
        }
        if ($scope.newPassword !== $scope.confirmPassword) {
            $scope.mes.passwordConfirm = "Mật khẩu phải giống với mật khẩu mới";
            $scope.check.passwordConfirm = true
            return;
        }

        const urlParams = new URLSearchParams(window.location.search);
        const username = urlParams.get("username");

        const url = `http://localhost:8080/confirm/reset-password?username=${username}&password=${$scope.newPassword}`;
        $http.put(url).then(function (response) {
            if (response.data.code == 100){
                alert("Thay đổi mật khẩu thành công");
                window.location.replace("/online/login");
            }
        }).catch(function (error) {
            console.log(error)
            alert("Thay đổi mật khẩu thất bại");
        })

    }

})