var app = angular.module('myApp', []);

app.controller('OrderController', function ($scope, $http) {
    $scope.cart = JSON.parse(sessionStorage.getItem('cart')) || [];
    $scope.sumPriceCart = $scope.cart.reduce((total, item) => total + item.quantity * item.price, 0);
    $scope.sumQuantity = $scope.cart.reduce((total, item) => total + item.quantity, 0)
    console.log("sumQuanity", $scope.sumQuantity)
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
                        $scope.getProvinces();
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
    $scope.moneySum = $scope.sumPriceCart;
    $scope.selectedVoucher = null;
    $scope.idVoucher = null;
    $scope.setMoney = function (discountMax, percent) {
        $scope.moneyAfterDiscount = $scope.sumPriceCart;
        $scope.moneyIsReduced = ($scope.moneyAfterDiscount * percent) / 100
        console.log("money" + $scope.moneyIsReduced)
        if ($scope.moneyIsReduced > discountMax) {
            $scope.moneyIsReduced = discountMax
            $scope.moneySum = $scope.moneySum - discountMax
        } else {
            $scope.moneySum = $scope.moneySum - $scope.moneyIsReduced
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
        if($scope.user.tinhTP === null||$scope.user.phuongXa === null||$scope.user.quanHuyen === null||$scope.user.diaChi === null){
            alert("Vui lòng cập nhật địa chỉ giao hàng.")
            window.location.href = "http://localhost:8080/user/detail"
            return;
        }

        if ($scope.idPTTT == 1) {
            if ($scope.moneyIsReduced) {
                if ($scope.idVoucher == null) {
                    var urlInsert = `http://localhost:8080/insert-bill/isnull?ship=${$scope.ship}&discount=${$scope.moneyIsReduced}&money=${$scope.moneySum}&sumMoney=${$scope.moneyAfterDiscount}&address=${$scope.diaChi}&idUser=${$scope.idUser}&idPTTT=${$scope.idPTTT}`;
                } else {
                    var urlInsert = `http://localhost:8080/insert-bill?ship=${$scope.ship}&discount=${$scope.moneyIsReduced}&money=${$scope.moneySum}&sumMoney=${$scope.moneyAfterDiscount}&address=${$scope.user.diaChi}&idUser=${$scope.idUser}&idVoucher=${$scope.idVoucher}&idPTTT=${$scope.idPTTT}`;
                }
            } else {
                if ($scope.idVoucher == null) {
                    var urlInsert = `http://localhost:8080/insert-bill/isnull?ship=${$scope.ship}&discount=0&money=${$scope.moneySum}&sumMoney=${$scope.moneyAfterDiscount}&address=${$scope.diaChi}&idUser=${$scope.idUser}&idPTTT=${$scope.idPTTT}`;
                } else {
                    var urlInsert = `http://localhost:8080/insert-bill?ship=${$scope.ship}&discount=0&money=${$scope.moneySum}&sumMoney=${$scope.moneyAfterDiscount}&address=${$scope.user.diaChi}&idUser=${$scope.idUser}&idVoucher=${$scope.idVoucher}&idPTTT=${$scope.idPTTT}`;
                }
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

    $scope.provinces = [];
    $scope.districts = [];
    $scope.wards = [];
    $scope.provincesUser = null;
    $scope.districtsUser = null;
    $scope.moneyShip = null;

    $scope.getProvinces = function () {
        const urlProvinces = `http://localhost:8080/public/provinces`;
        $http.get(urlProvinces).then(function (response) {
            if (response.data) {
                $scope.provinces = response.data.data;
                console.log("Tỉnh Thành Phố User", $scope.user.tinhTP)
                console.log($scope.provinces)
                $scope.provincesUser = $scope.provinces.find(item => item.ProvinceName === $scope.user.tinhTP);
                console.log($scope.provincesUser.ProvinceName)
                $scope.onProvinceChange($scope.provincesUser.ProvinceID)
            }
        });
    };

    $scope.onProvinceChange = function (provinceID) {
        const url = `http://localhost:8080/public/districts?province_id=${provinceID}`;
        $http.get(url).then(function (response) {
            if (response.data) {
                $scope.districts = response.data.data;
                $scope.districtsUser = $scope.districts.find(item => item.DistrictName === $scope.user.quanHuyen);
                console.log("Quận Huyện", $scope.districtsUser)
                $scope.onDistrictsChange($scope.districtsUser.DistrictID)
            }
        });
    };
    $scope.ship = null;

    $scope.onDistrictsChange = function (districtID) {
        const url = `http://localhost:8080/public/wards?district_id=${districtID}`;
        $http.get(url).then(function (response) {
            if (response.data) {
                $scope.wards = response.data.data;
                $scope.wardsUser = $scope.wards.find(item => item.WardName === $scope.user.phuongXa);

                const urlShip = `http://localhost:8080/public/transportationFee?to_district_id=${districtID}&to_ward_code=${$scope.wardsUser.WardCode}&quantity=${$scope.sumQuantity}`;

                $http.post(urlShip).then(function (response) {
                    console.log(response.data)
                    $scope.ship = response.data.data.total
                    $scope.moneySum = $scope.moneyAfterDiscount + $scope.ship
                })
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


});
