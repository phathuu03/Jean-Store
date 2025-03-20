var app = angular.module('myApp', []);

app.controller('RegisterController', function ($scope, $http, $location) {

    $scope.registerUser = function () {
        $scope.name = document.getElementById("name").value
        $scope.email = document.getElementById("email").value
        $scope.password = document.getElementById("password").value
        $scope.username = document.getElementById("username").value
        $scope.sdt = document.getElementById("sdt").value
        $scope.passwordConfirm = document.getElementById("passwordConfirm").value


        $scope.gender = document.getElementsByName("gender")
        for (let i = 0; i < $scope.gender.length; i++) {
            if ($scope.gender[i].checked) {
                $scope.gender = $scope.gender[i].value;
                break;
            }
        }
        const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.#$!%*?&])[A-Za-z\d@.#$!%*?&]{8,15}$/;
        let checkRegex = regex.test($scope.password)

        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        let checkEmailPattern = emailPattern.test($scope.email)

        const vietnamPhoneRegex = /^(0|\+84)(3[2-9]|5[2689]|7[0-9]|8[1-9]|9[0-9])[0-9]{7}$/
        let checkPhone = vietnamPhoneRegex.test($scope.sdt)

        $scope.check = {
            name: false,
            email: false,
            address: false,
            password: false,
            username: false,
            sdt: false,
            passwordConfirm: false
        }

        $scope.mes = {
            name: "",
            email: "",
            address: "",
            password: "",
            username: "",
            sdt: "",
            passwordConfirm: ""
        }
        if ($scope.name == null || $scope.name == "") {
            $scope.mes.name = "Không được để trống";
            $scope.check.name = true
            return;
        }
        if ($scope.username.length < 5 || $scope.username.length > 15) {
            $scope.mes.username = "Tên đăng nhập phải lớn hơn 5 ký tự và nhỏ hơn 15 ký tự";
            $scope.check.username = true
            return;
        }
        if ($scope.username == null || $scope.username == "") {
            $scope.mes.username = "Không được để trống";
            $scope.check.username = true
            return;
        }
        if ($scope.password == null || $scope.password == "") {
            $scope.mes.password = "Không được để trống";
            $scope.check.password = true
            return;
        }
        if ($scope.passwordConfirm == null || $scope.passwordConfirm == "") {
            $scope.mes.passwordConfirm = "Không được để trống";
            $scope.check.passwordConfirm = true
            return;
        }

        if ($scope.sdt == null || $scope.sdt == "") {
            $scope.mes.sdt = "Không được để trống";
            $scope.check.sdt = true
            return;
        }

        if ($scope.email == null || $scope.email == "") {
            $scope.mes.email = "Không được để trống";
            $scope.check.email = true
            return;
        }

        if (!checkRegex) {
            $scope.mes.password = "Mật khẩu phải chứa ít nhất một chữ in hoa,một chữ in thường, một chữ số và một ký tự đặc biệt.(Độ dài 8 - 15 ký tự.)";
            $scope.check.password = true;
            return;
        }
        if ($scope.password !== $scope.passwordConfirm) {
            $scope.mes.passwordConfirm = "Mật khẩu phải giống nhau";
            $scope.check.passwordConfirm = true
            return;
        }
        if (!checkPhone) {
            $scope.mes.sdt = "Số điện thoại không đúng!";
            $scope.check.sdt = true
            return;
        }

        if (!checkEmailPattern) {
            $scope.mes.email = "Email không đúng định dạng";
            $scope.check.email = true
            return;
        }


        const url = `http://localhost:8080/user/insert?name=${$scope.name}&username=${$scope.username}&password=${$scope.password}&sdt=${$scope.sdt}&email=${$scope.email}&gender=${$scope.gender}`;

        $http.get(url).then(function (response) {
            console.log(response.data.check)
            if (response.data.check == 10000) {
                $scope.mes.username = "Tài khoản đã tồn tại";
                $scope.check.username = true
                return;
            }
            console.log(response.status)
            if (response.status == 200) {
                alert("Đăng ký thành công");
                history.back()
            }
        }).catch(function (error) {
            console.log(error)
            alert("Đăng ký thất bại")
        })
    }

})