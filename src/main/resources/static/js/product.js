var app = angular.module('myApp', []);

app.controller('ProductController', function ($scope, $http, $timeout) {
        $timeout(function () {
            let buttons = document.querySelectorAll(".color-option");
            if (buttons.length > 0) {
                buttons[0].click();

                $timeout(function () {
                    let buttonSize = document.querySelectorAll(".size-option");
                    if (buttonSize.length > 0) {
                        buttonSize[0].click();
                    }
                }, 100);
            }
        }, 0);


        $scope.selectedColorId = null;
        $scope.selectedProductId = null;
        $scope.selectedSizeId = null;
        $scope.idProductDetail = null;
        $scope.priceProductDetail = null;
        $scope.size = null;
        $scope.quantity1 = null;
        $scope.currentImage = null;

        $scope.selectButtonSize = function (sizeId) {
            $scope.selectedSizeId = sizeId;
            if ($scope.selectedColorId && $scope.selectedProductId) {
                $scope.changeQuantity($scope.selectedProductId, sizeId);
            }
        };

        $scope.changeImage = function (colorId, productId) {

            $timeout(function () {
                let buttonSize = document.querySelectorAll(".size-option");
                if (buttonSize.length > 0) {
                    buttonSize[0].click();
                }
            }, 50);

            $scope.selectedColorId = colorId;
            $scope.selectedProductId = productId;

            const urlSizeOn = `http://localhost:8080/getSizeByColor?id=${productId}&colorId=${colorId}`;


            $http.get(urlSizeOn).then(function (response) {
                if (response.data.size) {
                    $scope.size = response.data.size
                    console.log("size", response.data.size)
                }
            })

            if (!colorId || !productId) {
                console.error("colorId hoặc productId bị rỗng hoặc không hợp lệ!");
                return;
            }

            const url = `http://localhost:8080/home/product-detail/color?colorId=${colorId}&productId=${productId}`;
            console.log(url);
            console.log("Selected Color ID:", colorId, "Product ID:", productId);

            $http.get(url)
                .then(function (response) {
                    console.log("Response từ server:", response.data);
                    if (response.data.imageUrl) {
                        $scope.currentImage = response.data.imageUrl;
                        document.getElementById("productImageDetail").src = $scope.currentImage;
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi khi đổi ảnh:", error);
                });


        };

        $scope.changeQuantity = function (productId, sizeId) {

            const urlId = `http://localhost:8080/home/getIdProductDetail?colorId=${$scope.selectedColorId}&productId=${$scope.selectedProductId}&sizeId=${sizeId}`;
            const urlQuantity = `http://localhost:8080/home/change-quantity?colorId=${$scope.selectedColorId}&productId=${productId}&sizeId=${sizeId}`;

            $http.get(urlQuantity)
                .then(function (response) {
                    console.log("Response từ server:", response.data);
                    if (response.data.quantity !== undefined) {
                        $scope.quantity1 = response.data.quantity;
                        document.getElementById("quantityText").innerText = $scope.quantity1;
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi khi sửa số lượng", error);
                });

            // Lấy ID Quần Jeans Chi Tiết
            $http.get(urlId)
                .then(function (response) {
                    console.log("Response từ server:", response.data);
                    if (response.data.id !== undefined) {
                        console.log("IdProductDetail" + response.data.id)
                        $scope.idProductDetail = response.data.id;
                        const urlGetPrice = `http://localhost:8080/getPrice?id=${$scope.idProductDetail}`;
                        $http.get(urlGetPrice).then(function (response) {
                            if (response.data) {
                                $scope.priceProductDetail = response.data
                                document.getElementById("product-price").innerText =
                                    $scope.priceProductDetail.toLocaleString('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND'
                                    });

                            }
                        })
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi", error);
                });
        };
        $scope.quantity = 0; // Giá trị mặc định
        $scope.increaseQuantity = function () {
            $scope.$watch('idProductDetail', function (newValue, oldValue) {
                if (newValue !== oldValue) {
                    $scope.quantity = 0
                }
            });
            $scope.$watch('selectedColorId', function (newValue, oldValue) {
                if (newValue !== oldValue) {
                    $scope.quantity = 0
                }
            });
            if ($scope.quantity < $scope.quantity1) {
                $scope.quantity++;
            }
        };

        $scope.decreaseQuantity = function () {
            if ($scope.quantity > 1) { // Đảm bảo số lượng tối thiểu là 1
                $scope.quantity--;
            }
        };

        $scope.insetCart = function (idKhachHang) {
            const url = `http://localhost:8080/cart/insert?idProductDetail=${$scope.idProductDetail}&quantity=${$scope.quantity}&idKhachHang=${idKhachHang}`;
            $http.post(url).then(function (response) {
                console.log(response.status)
            })
        }


        $scope.nameProduct = null;
        $scope.nameColor = null;
        $scope.nameSize = null;
        $scope.idUser = null;

        $scope.cart = JSON.parse(sessionStorage.getItem('cart')) || [];


        $scope.getIdUser = function () {
            const urlGetIdUser = `http://localhost:8080/user/id`;
            $http.get(urlGetIdUser)
                .then(function (response) {
                    if (response.data.id) {
                        $scope.idUser = response.data.id;
                        console.log("ID User:", $scope.idUser);
                    } else {
                        return;
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi khi lấy ID user:", error);
                });
        };


        $scope.cartUser = null;

        $scope.cartUserToCartLocal = function () {
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
                                        $scope.cart = cartUserlocal
                                    }
                                })
                                .catch(function (error) {
                                    console.error("Lỗi khi đổi ảnh:", error);
                                });
                        })
                }
            })
        }


        $scope.addToCart = function () {

                let isQuantityExceeded = $scope.cart.some(
                    item => {
                        if (item.idProductDetail == $scope.idProductDetail) {
                            if ((item.quantity + parseInt($scope.quantity)) > item.quantityReal) {
                                alert("Số lượng bạn thêm với số lượng trong giỏ đã vượt quá số lượng trong kho !");
                                return true;
                            }
                        }
                        return false;
                    }
                )
                if (isQuantityExceeded) return;

                $scope.getIdUser();
                $timeout(function () {
                    if ($scope.idUser != null) {
                        sessionStorage.clear();
                        $scope.insetCart($scope.idUser);
                        $timeout(function () {
                            $scope.cartUserToCartLocal();
                            alert("Sản phẩm đã được thêm vào giỏ hàng!");
                        }, 50);

                    } else {
                        if (!$scope.idProductDetail || $scope.quantity <= 0) {
                            alert("Vui lòng chọn màu, size và số lượng hợp lệ.");
                            return;
                        }
                        const urlNameColor = `http://localhost:8080/getNameColor?idMauSac=${$scope.selectedColorId}`;
                        const urlNameProduct = `http://localhost:8080/getNameProduct?idProduct=${$scope.selectedProductId}`;
                        const urlNameSize = `http://localhost:8080/getNameSize?idSize=${$scope.selectedSizeId}`;


                        var requests = [
                            $http.get(urlNameColor).then(function (response) {
                                if (response.data.nameColor != undefined) {
                                    $scope.nameColor = response.data.nameColor;
                                }
                            }),
                            $http.get(urlNameProduct).then(function (response) {
                                if (response.data.nameProduct != undefined) {
                                    $scope.nameProduct = response.data.nameProduct;
                                }
                            }),
                            $http.get(urlNameSize).then(function (response) {
                                if (response.data.nameSize != undefined) {
                                    $scope.nameSize = response.data.nameSize;
                                }
                            })
                        ];

// Chờ tất cả các yêu cầu hoàn thành
                        Promise.all(requests).then(function () {
                            let cart = JSON.parse(sessionStorage.getItem('cart')) || [];

                            // Kiểm tra dữ liệu hợp lệ trước khi thêm vào giỏ hàng
                            if (!$scope.idProductDetail || !$scope.nameProduct || !$scope.nameColor || !$scope.nameSize) {
                                alert("Dữ liệu sản phẩm không hợp lệ, vui lòng kiểm tra lại!");
                                return;
                            }

                            let existingItem = cart.find(item => item.idProductDetail === $scope.idProductDetail);
                            if (existingItem) {
                                existingItem.quantity += $scope.quantity;
                            } else {
                                let imageElement = document.getElementById("productImageDetail");
                                let imageUrl = imageElement ? imageElement.src : "";

                                cart.push({
                                    idProductDetail: $scope.idProductDetail,
                                    name: $scope.nameProduct,
                                    color: $scope.nameColor,
                                    size: $scope.nameSize,
                                    price: $scope.priceProductDetail,
                                    quantity: parseInt($scope.quantity),
                                    quantityReal: parseInt($scope.quantity1),
                                    image: imageUrl
                                });
                            }

                            sessionStorage.setItem('cart', JSON.stringify(cart));
                            $scope.cart = cart
                            console.log("Giỏ hàng hiện tại:", cart);
                            alert("Sản phẩm đã được thêm vào giỏ hàng!");
                        });

                    }
                }, 50);
        };
    }
)


function selectButtonColor(btn) {
    // Bỏ class active khỏi tất cả các nút
    document.querySelectorAll(".color-option").forEach(button => {
        button.classList.remove("active");
    });

    // Thêm class active vào nút được chọn
    btn.classList.add("active");
}

function selectButtonSize1(btn) {
    // Bỏ class active khỏi tất cả các nút
    document.querySelectorAll(".size-option").forEach(button => {
        button.classList.remove("active");
    });

    // Thêm class active vào nút được chọn
    btn.classList.add("active");
}