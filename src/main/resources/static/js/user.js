var app = angular.module('myApp', []);

app.controller('UserController', function ($scope, $http) {

        $scope.name = document.getElementById("name").value
        $scope.email = document.getElementById("email").value
        $scope.address = document.getElementById("address").value
        $scope.password = document.getElementById("password").value


        $scope.gender = document.getElementsByName("gender")
        for (let i = 0; i < $scope.gender.length; i++) {
            if ($scope.gender[i].checked) {
                $scope.gender = $scope.gender[i].value;
                break;
            }
        }

        $scope.changePassword = function () {
            $scope.passwordCurrent = document.getElementById("currentPassword").value
            $scope.passwordNew = document.getElementById("newPassword").value
            $scope.passwordConfirm = document.getElementById("confirmPassword").value

            let regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.#$!%*?&])[A-Za-z\d@.#$!%*?&]{8,15}$/;
            let checkRegex = regex.test($scope.passwordNew)

            $scope.check = {
                passwordCurrent: false,
                passwordNew: false,
                passwordConfirm: false
            }

            $scope.mes = {
                passwordCurrent: "",
                passwordNew: "",
                passwordConfirm: ""
            }

            if ($scope.passwordCurrent == null || $scope.passwordCurrent == "") {
                $scope.mes.passwordCurrent = "Không được để trống";
                $scope.check.passwordCurrent = true
                return;
            }
            if ($scope.passwordNew == null || $scope.passwordNew == "") {
                $scope.mes.passwordNew = "Không được để trống";
                $scope.check.passwordNew = true
                return;
            }
            if ($scope.passwordConfirm == null || $scope.passwordConfirm == "") {
                $scope.mes.passwordConfirm = "Không được để trống";
                $scope.check.passwordConfirm = true
                return;
            }
            if (!checkRegex) {
                $scope.mes.passwordNew = "Mật khẩu phải chứa ít nhất một chữ in hoa,một chữ in thường, một chữ số và một ký tự đặc biệt.(Độ dài 8 - 15 ký tự.)";
                $scope.check.passwordNew = true;
                return;
            }
            if ($scope.password !== $scope.passwordCurrent) {
                $scope.mes.passwordCurrent = "Mật khẩu không đúng";
                $scope.check.passwordCurrent = true
                return;
            }
            if ($scope.passwordNew !== $scope.passwordConfirm) {
                $scope.mes.passwordConfirm = "Mật khẩu phải giống với mật khẩu mới";
                $scope.check.passwordConfirm = true
                return;
            }

            const url = `http://localhost:8080/user/update/password?password=${$scope.passwordConfirm}`;
            $http.put(url).then(function (response) {
                if (response.status == 200) {
                    console.log(response.data.mes)
                    alert("Thay đổi mật khẩu thành công")
                    location.reload()
                }
            }).catch(function (error) {
                console.log(error)
                alert("Thay đổi mật khẩu thất bại")
            })
        }

        $scope.check = false

        $scope.updateUser = function () {


            $scope.name1 = document.getElementById("name").value
            $scope.email1 = document.getElementById("email").value
            $scope.address1 = document.getElementById("address").value

            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            let checkEmailPattern = emailPattern.test($scope.email1)

            $scope.gender1 = document.getElementsByName("gender")
            for (let i = 0; i < $scope.gender1.length; i++) {
                if ($scope.gender1[i].checked) {
                    $scope.gender1 = $scope.gender1[i].value;
                    break;
                }
            }

            if ($scope.name !== $scope.name1) {
                $scope.check = true
            }
            if ($scope.gender !== $scope.gender1) {
                $scope.check = true
            }
            if ($scope.email !== $scope.email1) {
                $scope.check = true
            }
            if ($scope.address !== $scope.address1) {
                $scope.check = true
            }


            if (!$scope.check) {
                alert("Bạn chưa thay đổi thông tin!");
                return;
            }
            $scope.checkError = {
                name: false,
                email: false,
                address: false
            }

            $scope.mes = {
                name: "",
                email: "",
                address: ""
            }

            if ($scope.name1 == null || $scope.name1 == "") {
                $scope.mes.name = "Không được để trống";
                $scope.checkError.name = true
                return;
            }
            if ($scope.email1 == null || $scope.email1 == "") {
                $scope.mes.email = "Không được để trống";
                $scope.checkError.email = true
                return;
            }
            if ($scope.address1 == null || $scope.address1 == "") {
                $scope.mes.address = "Không được để trống";
                $scope.checkError.address = true
                return;
            }

            if (!checkEmailPattern) {
                $scope.mes.email = "Email không đúng định dạng";
                $scope.checkError.email = true
                return;
            }
            const url = `http://localhost:8080/user/update?gender=${$scope.gender1}&email=${$scope.email1}&name=${$scope.name1}`;
            $http.put(url).then(function (response) {
                if (response.status == 200) {
                    console.log(response.data.alert)
                    alert("Cập nhật thông tin thành công !")
                    location.reload()
                }
            }).catch(function (error) {
                console.log("error", error)
            })
            console.log($scope.name)
            console.log($scope.email)
            console.log($scope.address)
            console.log($scope.gender)
        }

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
        $scope.provinces = [];
        $scope.districts = [];
        $scope.wards = [];

        $scope.getProvinces = function () {
            const urlProvinces = `http://localhost:8080/public/provinces`;
            $http.get(urlProvinces).then(function (response) {
                if (response.data) {
                    $scope.provinces = response.data.data;
                    console.log("Provinces loaded:", response.data);
                }
            });
        };

        $scope.onProvinceChange = function (provinceID) {
            $scope.districts = []; // Xóa dữ liệu quận/huyện khi chọn tỉnh mới
            $scope.wards = []; // Xóa dữ liệu phường/xã

            const url = `http://localhost:8080/public/districts?province_id=${provinceID}`;
            $http.get(url).then(function (response) {
                if (response.data) {
                    $scope.districts = response.data.data;
                    console.log("Districts loaded:", response.data);
                }
            });
        };

        $scope.onDistrictsChange = function (districtID) {
            $scope.wards = []; // Xóa dữ liệu phường/xã khi chọn quận/huyện mới

            const url = `http://localhost:8080/public/wards?district_id=${districtID}`;
            $http.get(url).then(function (response) {
                if (response.data) {
                    $scope.wards = response.data.data;
                    console.log("Wards loaded:", response.data);
                }
            });
        };

        $scope.changeAddress = function () {
            let addressDetail = document.getElementById("addressDetail").value;

            let selectedProvince = $scope.provinces.find(p => p.ProvinceID == $scope.selectedProvince);
            let selectedDistrict = $scope.districts.find(d => d.DistrictID == $scope.selectedDistricts);
            let selectedWard = $scope.wards.find(w => w.WardCode == $scope.selectedWards);


            if (!selectedDistrict || !selectedDistrict || !selectedWard || !addressDetail) {
                alert("Vui lòng điền đầy đủ thông tin")
                return
            }

            const url = `http://localhost:8080/user/update/address?address=${addressDetail}&provinces=${selectedProvince.ProvinceName}&districts=${selectedDistrict.DistrictName}&wards=${selectedWard.WardName}`
            $http.get(url).then(function (response) {
                if (response.data.mes === "OK") {
                    console.log("Cập nhật địa chỉ thành công:", response.data.mes);
                    alert("Thay đổi thành công địa chỉ")
                    location.reload()
                }
            });
        };


        $scope.getProvinces();
    }
)