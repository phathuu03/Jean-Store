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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">

</head>
<style>
    html, body {
        height: 100%;
        margin: 0;
        display: flex;
        flex-direction: column;
    }

    .container {
        flex: 1;
    }

    .footer {
        color: white;
        text-align: center;
        padding: 10px 0;
        width: 100%;
    }
    .disable-click {
        pointer-events: none;
        opacity: 0.5;
    }
</style>

<body style="background-color: aliceblue">
<header class="p-3 bg-dark text-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between">
            <!-- Logo -->
            <a class="navbar-brand fw-bold text-primary d-flex align-items-center" href="/home">
                <i class="bi bi-bag me-2"></i> Jeans Store
            </a>

            <!-- Menu -->
            <ul class="nav col-lg-auto mb-2 mb-lg-0">
                <li><a href="/home" class="nav-link px-3 text-white">Trang chủ</a></li>
                <li><a href="/order-history" class="nav-link px-3 text-white">Quản lý đơn hàng</a></li>
                <li><a href="/cart/detail" class="nav-link px-3 text-white">Giỏ hàng</a></li>
                <li><a href="/user/detail" class="nav-link px-3 text-white">Tài khoản</a></li>
            </ul>

            <!-- Đăng nhập / Chào mừng -->
            <div class="d-flex align-items-center">
                <a href="/online/login" id="btnLogin" class="btn btn-outline-light me-3">Đăng nhập</a>
                <p id="textWelcome" class="mb-0 fw-bold text-light" style="display: none;"></p>
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
            <tr ng-repeat="item in cart track by item.idProductDetail">
                <td><img ng-src="{{ item.image }}" width="50"></td>
                <td>{{ item.name }}</td>
                <td>{{ item.color }}</td>
                <td>{{ item.size }}</td>
                <td>{{ item.price | number:0 }} VND</td>
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
                <td>{{ (item.quantity * item.price) | number:0 }} VND</td>
                <td>
                    <button ng-click="removeFromCart(item.idProductDetail)">Xóa</button>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-end align-items-center">
            <div>
                <h5>Tổng thanh toán: <span class="text-danger">{{sumPriceCart | number:0 }} VND</span></h5>
                <a id="btnPurchase" href="/order/checkout" ng-class="{'disabled': cart.length === 0}"
                   class="btn btn-success">Mua Hàng</a>
            </div>
        </div>
    </div>
</div>
<div class="footer mt-auto">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
        <div class="container d-flex justify-content-between">
            <span class="text-muted">© 2025 Company, Jeans Store</span>
            <ul class="nav list-unstyled d-flex">
                <li class="ms-3"><a class="text-muted" href="#"><i class="bi bi-facebook"></i></a></li>
                <li class="ms-3"><a class="text-muted" href="#"><i class="bi bi-twitter"></i></a></li>
                <li class="ms-3"><a class="text-muted" href="#"><i class="bi bi-instagram"></i></a></li>
            </ul>
        </div>
    </footer>
</div>
</div>
</body>
</html>


