var app = angular.module('myApp', []);

app.controller('ProductController', function ($scope, $http) {

        $scope.selectedColorId = null;
        $scope.selectedProductId = null;
        $scope.selectedSizeId = null;
        $scope.idProductDetail = null;


        $scope.changeImage = function (colorId, productId) {
            $scope.selectedColorId = colorId;
            $scope.selectedProductId = productId;
            $scope.selectButtonSize = function (sizeId) {
                $scope.selectedSizeId = sizeId;
                if ($scope.selectedColorId && $scope.selectedProductId) {
                    $scope.changeQuantity($scope.selectedProductId, sizeId);
                }
            };

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

                    if ($scope.selectedSizeId) {
                        $scope.changeQuantity(productId, $scope.selectedSizeId);
                    }
                })
                .catch(function (error) {
                    console.error("Lỗi khi đổi ảnh:", error);
                });
        };


        $scope.changeQuantity = function (productId, sizeId) {

            const urlId = `http://localhost:8080/home/getIdProductDetail?colorId=${$scope.selectedColorId}&productId=${$scope.selectedProductId}&sizeId=${sizeId}`;
            const urlQuantity = `http://localhost:8080/home/change-quantity?colorId=${$scope.selectedColorId}&productId=${productId}&sizeId=${sizeId}`;
            console.log("Fetching quantity from:", urlQuantity);

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
            if ($scope.quantity < $scope.quantity1) {
                $scope.quantity++;
            }
        };

        $scope.decreaseQuantity = function () {
            if ($scope.quantity > 1) { // Đảm bảo số lượng tối thiểu là 1
                $scope.quantity--;
            }
        };

        // CART
        // $scope.insetCart = function (){
        //     const url = `http://localhost:8080/cart/insert?idProductDetail=${$scope.idProductDetail}&quantity=${$scope.quantity}&idKhachHang=1`;
        //     $http.post(url).then(function (response) {
        //         console.log(response.status)
        //     })
        // }



    $scope.nameProduct = null;
    $scope.nameColor = null;
    $scope.nameSize = null;

    $scope.cart = JSON.parse(localStorage.getItem('cart')) || [];

    $scope.addToCart = function () {
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
            let cart = JSON.parse(localStorage.getItem('cart')) || [];

            let existingItem = cart.find(item => item.idProductDetail === $scope.idProductDetail);
            if (existingItem) {
                existingItem.quantity += $scope.quantity;
            } else {
                cart.push({
                    idProductDetail: $scope.idProductDetail,
                    name: $scope.nameProduct,
                    color: $scope.nameColor,
                    size: $scope.nameSize,
                    price: parseFloat(document.querySelector('.product-price').innerText),
                    quantity: parseInt($scope.quantity),
                    quantityReal: parseInt($scope.quantity1),
                    image: document.getElementById("productImageDetail").src
                });
            }

            localStorage.setItem('cart', JSON.stringify(cart));
            console.log("price"+cart.price)
            console.log("quantity"+cart.quantity)
            alert("Sản phẩm đã được thêm vào giỏ hàng!");
        });

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