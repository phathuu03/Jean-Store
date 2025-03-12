var app = angular.module('myApp', []);

app.controller('CartController', function ($scope, $http) {
    $scope.cart = JSON.parse(sessionStorage.getItem('cart')) || [];
    $scope.updateTotalPrice = function () {
        $scope.sumPriceCart = $scope.cart.reduce((total, item) => total + item.quantity * item.price, 0);

    };

    $scope.cartUser = null;
    $scope.init = function (idUser) {
        if (idUser != null) {
            sessionStorage.clear();
            const urlCartDetail = `http://localhost:8080/cart/detail/user?id=${$scope.idUser}`;
            $http.get(urlCartDetail).then(function (response) {
                if (response.data) {
                    $scope.cartUser = response.data.cart
                    console.log("alo", $scope.cartUser)
                    let cartUserlocal = JSON.parse(sessionStorage.getItem('cart')) || [];
                    $scope.cartUser.forEach(
                        item => {
                            console.log("productId", item.quanJeansChiTietDTO.quanJeansDTO.id)
                            console.log("productId", item.quanJeansChiTietDTO.mauSac.id)
                            const url = `http://localhost:8080/home/product-detail/color?colorId=${item.quanJeansChiTietDTO.mauSac.id}&productId=${item.quanJeansChiTietDTO.quanJeansDTO.id}`;
                            $http.get(url)
                                .then(function (response) {
                                    console.log("Response từ server:", response.data);
                                    if (response.data.imageUrl) {
                                        cartUserlocal.push({
                                            idProductDetail: item.quanJeansChiTietDTO.id,
                                            name: item.quanJeansChiTietDTO.quanJeansDTO.tenSanPham,
                                            color: item.quanJeansChiTietDTO.mauSac.tenMauSac,
                                            size: item.quanJeansChiTietDTO.size.tenSize,
                                            price: item.quanJeansChiTietDTO.gia,
                                            quantity: item.soLuong,
                                            quantityReal: item.quanJeansChiTietDTO.soLuong,
                                            image: response.data.imageUrl
                                        });
                                        sessionStorage.setItem('cart', JSON.stringify(cartUserlocal));
                                        $scope.cart = JSON.parse(sessionStorage.getItem('cart')) || [];
                                        $scope.updateTotalPrice()
                                    }
                                })
                                .catch(function (error) {
                                    console.error("Lỗi khi đổi ảnh:", error);
                                });
                        })
                }
            })
        }
    }

    $scope.idUser = null;

    $scope.getUser = function () {
        const urlGetIdUser = `http://localhost:8080/user/id`;
        $http.get(urlGetIdUser)
            .then(function (response) {
                if (response.data.id) {
                    $scope.idUser = response.data.id;
                    $scope.init($scope.idUser);
                    console.log("ID User:", $scope.idUser);
                } else {
                    throw new Error("Không tìm thấy ID User");
                }
            })
            .catch(function (error) {
                console.error("Lỗi khi lấy ID user:", error);
            });
    };
    $scope.getUser();

    $scope.updateQuantityOnclick = function (idProductDetail, idUser, quantity) {
        if ($scope.idUser != null) {
            const urlUpdateQuantity = `http://localhost:8080/update-quantity/onclick?idProductDetail=${idProductDetail}&idKhachHang=${idUser}&quantity=${quantity}`;
            $http.put(urlUpdateQuantity).then(function (response) {
                if (response.status) {
                    console.log("update Ok")
                }
            }).catch(function (error) {
                console.log("error", error)
            })
        }
    };


    $scope.decreaseQuantityCart = function (item) {
        if (item.quantity > 1) {
            item.quantity--;
        }
        sessionStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.updateQuantityOnclick(item.idProductDetail, $scope.idUser, item.quantity)
        $scope.updateTotalPrice();
    };
    $scope.increaseQuantityCart = function (item) {
        if (item.quantity < item.quantityReal) {
            item.quantity++;
        }
        sessionStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.updateQuantityOnclick(item.idProductDetail, $scope.idUser, item.quantity)
        $scope.updateTotalPrice();
    };
    $scope.removeFromCart = function (id) {

        let isConfirm = confirm("Bạn có muốn xóa không");

        if (!isConfirm){
            return;
        }

        $scope.cart = $scope.cart.filter(item => item.idProductDetail !== id);
        sessionStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.updateTotalPrice();

        if ($scope.idUser != null) {
            const urlDelete = `http://localhost:8080/delete-cart/onclick?idKhachHang=${$scope.idUser}&idQuan=${id}`;
            $http.delete(urlDelete).then(function (response) {
                if (response.status == 200) {
                    console.log("result :", response.data);
                }
            }).catch(function (error) {
                console.log("error : ", error)
            })
        }
    };

    $scope.updateTotalPrice();
})
;