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
    <script src="${pageContext.request.contextPath}/js/product.js"></script>
    <%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">--%>

</head>
<style>
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
    #productImageDetail{
        width: 500px;
        height: 500px;
    }
</style>
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

<div class="content container mt-5">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 border rounded p-3 bg-light">
            <h5 class="text-center">Thương Hiệu</h5>
            <hr>
            <c:forEach var="item" items="${thuongHieu}">
                <a href="#" class="product-link d-block text-decoration-none text-dark">${item.tenThuongHieu}</a>
            </c:forEach>
        </div>

        <!-- Product Details -->
        <div ng-app="myApp" ng-controller="ProductController" class="col-md-9">
            <div class="card shadow-sm p-3">
                <div class="row">
                    <!-- Product Image -->
                    <div class="col-md-6 text-center">
                        <img id="productImageDetail" src="${quanJeans.hinhAnh[0].url} on"
                             alt="Hình ảnh sản phẩm" class="img-fluid rounded">
                    </div>

                    <!-- Product Info -->
                    <div class="col-md-6 d-flex flex-column justify-content-center">
                        <h4 class="fw-bold">${quanJeans.tenSanPham}</h4>

                        <c:forEach var="quanCT" items="${quanJeans.quanJeansChiTiets}" begin="0" end="0">
                            <label class="product-price text-danger fw-bold fs-5">${quanCT.gia}</label>
                        </c:forEach>

                        <div class="mt-4">
                            <h6 class="fw-bold">Màu sắc:</h6>
                            <div class="d-flex flex-wrap gap-2">
                                <c:forEach var="mauSac" items="${mauSac}">
                                    <button value="${mauSac[1]}" class="color-option btn btn-outline-dark btnMauSac"
                                            ng-click="changeImage(${mauSac[1]},${quanJeans.id})"
                                            onclick="selectButtonColor(this)"
                                           >
                                            ${mauSac[0]}
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="mt-4">
                            <h6 class="fw-bold">Size:</h6>
                            <div class="d-flex flex-wrap gap-2">
                                <c:forEach var="size" items="${size}">
                                    <button class="size-option btn btn-outline-dark btnSize"
                                            ng-click="selectButtonSize(${size[0]})"
                                            onclick="selectButtonSize1(this)">
                                            ${size[1]}
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="mt-4">
                            <h6 class="fw-bold">Số lượng trong kho:</h6>
                            <p id="quantityText" class="fs-5 text-danger fw-bold">0</p>
                        </div>
                        <div class="mt-4">
                            <h6 class="fw-bold">Số lượng:</h6>
                            <div class="input-group" style="width: 120px;">
                                <button class="btn btn-outline-secondary" type="button" ng-click="decreaseQuantity()">
                                    −
                                </button>
                                <input type="text" class="form-control text-center text-danger fw-bold" id="quantityInput"
                                       ng-model="quantity" readonly>
                                <button class="btn btn-outline-secondary" type="button" ng-click="increaseQuantity()">
                                    +
                                </button>
                            </div>
                        </div>
                        <button class="btn btn-primary mt-3" ng-click="addToCart()">Thêm vào giỏ hàng</button>
                    </div>
                </div>
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


