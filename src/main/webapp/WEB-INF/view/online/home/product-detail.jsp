<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    <script src="${pageContext.request.contextPath}/js/product.js"></script>

</head>
<style>
    .d-flex {
        display: flex;
        flex-wrap: wrap; /* Cho phép các nút tự động xuống dòng nếu không đủ chỗ */
        gap: 10px; /* Khoảng cách giữa các nút */
    }

    .size-option {
        min-width: 50px; /* Đặt chiều rộng tối thiểu */
        text-align: center;
        padding: 10px 15px;
    }

    .color-option.active {
        background-color: black;
        color: white;
        border-color: black;
    }

    .size-option.active {
        background-color: black;
        color: white;
        border-color: black;
    }

    #productImageDetail {
        width: 400px;
        height: 400px;
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


<div class="content container mt-5">
    <div class="container my-5">
        <div class="row" ng-app="myApp" ng-controller="ProductController">

            <!-- Product Image -->
            <div class="col-md-6 text-center">
                <img id="productImageDetail" src="${quanJeans.hinhAnh[0].url}" alt="Hình ảnh sản phẩm"
                     class="shadow-sm">
            </div>

            <!-- Product Information -->
            <div class="col-md-6 product-details">
                <h2 class="fw-bold">${quanJeans.tenSanPham}</h2>

                <c:forEach var="quanCT" items="${quanJeans.quanJeansChiTiets}" begin="0" end="0">
                    <p class="product-price" id="product-price"
                       style="font-size: 25px;color: #dd4b39;font-weight: bold">
                        <fmt:formatNumber value="${quanCT.gia}" type="currency" currencySymbol="đ"/>
                    </p>
                </c:forEach>
                <h6 class="fw-bold mt-4">Chi Tiết:</h6>
                <p>Thương hiệu : ${quanJeans.thuongHieu.tenThuongHieu}</p>
                <p>Chất liệu : ${quanJeans.chatLieu.tenChatLieu}</p>
                <p>Ống quần : ${quanJeans.ongQuan.tenOngQuan}</p>

                <!-- Màu sắc -->
                <h6 class="fw-bold mt-4">Màu sắc:</h6>
                <div class="d-flex flex-wrap gap-2">
                    <c:forEach var="mauSac" items="${mauSac}">
                        <button value="${mauSac[1]}" class="color-option btn btn-outline-dark"
                                id="btnColor"
                                ng-click="changeImage(${mauSac[1]}, ${quanJeans.id})"
                                onclick="selectButtonColor(this)">
                                ${mauSac[0]}
                        </button>
                    </c:forEach>
                </div>

                <!-- Size -->
                <h6 class="fw-bold mt-4">Size:</h6>
                <div class="d-flex flex-wrap gap-2">
                    <button class="size-option btn btn-outline-dark"
                            id="btnSize"
                            ng-repeat="s in size"
                            ng-click="selectButtonSize(s[0])"
                            onclick="selectButtonSize1(this)"
                            value="{{s[0]}}">
                        {{s[1]}}
                    </button>
                </div>


                <!-- Số lượng trong kho -->
                <h6 class="fw-bold mt-4">Số lượng trong kho:</h6>
                <p id="quantityText" class="fs-5 text-danger fw-bold">0</p>

                <!-- Số lượng -->
                <h6 class="fw-bold mt-4">Số lượng:</h6>
                <div class="input-group" style="width: 120px;">
                    <button class="btn btn-outline-secondary" type="button" ng-click="decreaseQuantity()">−</button>
                    <input type="text" class="form-control quantity-input" id="quantityInput" ng-model="quantity"
                           readonly>
                    <button class="btn btn-outline-secondary" type="button" ng-click="increaseQuantity()">+</button>
                </div>

                <!-- Thêm vào giỏ hàng -->
                <button class="btn btn-primary mt-4 w-100" id="btnAddToCart" ng-click="addToCart()" ng-class="{'disabled': quantity1 === 0}">
                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ hàng
                </button>
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


