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

    $scope.loadImages();

    $scope.setTTHuy = function (id) {
        const url = `http://localhost:8080/update/tt-huy?id=${id}`;

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
