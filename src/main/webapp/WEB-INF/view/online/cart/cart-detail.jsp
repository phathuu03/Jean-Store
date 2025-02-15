<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Jeans-Store</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://code.angularjs.org/1.8.2/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular-route.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="${pageContext.request.contextPath}/js/cart.js"></script>
</head>

<body style="background-color: aliceblue">
<header class="p-3 bg-dark textwhite">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <div class="d-flex align-items-center mb-2 mb-lg-0 text-red text-decoration-none"
                 style="color: cornflowerblue">
                Jeans Store
            </div>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/home" class="nav-link px-2 text-white">Trang chủ</a></li>
                <li><a href="#" class="nav-link px-2 text-white">Quản lý đơn hàng</a></li>
                <li><a href="/cart/detail" class="nav-link px-2 text-white">Giỏ hàng</a></li>
            </ul>

            <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
                <input type="search" class="form-control form-control-dark" placeholder="Search..." aria-label="Search">
            </form>

            <div class="text-end">
                <button type="button" class="btn btn-outline-light me-2">Login</button>
                <button type="button" class="btn btn-warning">Sign-up</button>
            </div>
        </div>
    </div>
</header>

<div ng-app="myApp" ng-controller="CartController">
    <div class="container mt-4">
        <h2 class="mb-4">Giỏ Hàng</h2>
        <table class="table table-bordered">
            <thead class="table-light">
            <tr>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Màu sắc</th>
                <th>Size</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tổng tiền:</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <tr ng-repeat="item in cart">
                <td><img ng-src="{{ item.image }}" width="50"></td>
                <td>{{ item.name }}</td>
                <td>{{ item.color }}</td>
                <td>{{ item.size }}</td>
                <td>{{ item.price | currency:"đ "}}</td>
                <td>
                    <div class="input-group" style="width: 120px;">
                        <button class="btn btn-outline-secondary" type="button" ng-click="decreaseQuantityCart(item)">
                            −
                        </button>
                        <input type="text" class="form-control text-center text-danger fw-bold" id="quantityInputCart"
                               ng-model="item.quantity" readonly>
                        <button class="btn btn-outline-secondary" type="button" ng-click="increaseQuantityCart(item)">
                            +
                        </button>
                    </div>
                </td>
                <td>{{ item.quantity * item.price | currency:"đ "}}</td>
                <td>
                    <button ng-click="removeFromCart(item.idProductDetail)">Xóa</button>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-end align-items-center">
            <div>
                <h5>Tổng thanh toán: <span class="text-danger">{{sumPriceCart | currency:"đ "}}</span></h5>
                <a href="/order/checkout" class="btn btn-success" ng-click = "getAchat()" >Mua Hàng</a>
            </div>
        </div>
    </div>
</div>
<div class="footer">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top fixed-bottom">
        <div class="col-md-4 d-flex align-items-center">
            <a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                <svg class="bi" width="30" height="24">
                    <use xlink:href="#bootstrap"></use>
                </svg>
            </a>
            <span class="text-muted">© 2025 Company, Jeans Store</span>
        </div>

        <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">

        </ul>
    </footer>
</div>
</div>
</body>
</html>


