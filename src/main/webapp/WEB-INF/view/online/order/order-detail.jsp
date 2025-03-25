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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <script src="${pageContext.request.contextPath}/js/order-history.js"></script>


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

    body {
        background-color: #f8f9fa;
    }

    .navbar {
        background-color: white;
        padding: 10px 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .nav-link {
        color: black;
        font-weight: 500;
        padding: 10px 15px;
    }

    .nav-link.active, .nav-link:hover {
        color: #d9534f;
        border-bottom: 2px solid #d9534f;
    }

    .order-container {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    }

    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 10px;
        border-bottom: 2px solid #eee;
    }

    .order-status {
        color: #d9534f;
        font-weight: bold;
    }

    .order-item {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }

    .order-item img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 5px;
        border: 1px solid #ddd;
    }

    .order-item-info {
        flex-grow: 1;
    }

    .order-footer {
        display: flex;
        color: #dd4b39;
        justify-content: space-between;
        align-items: center;
        padding-top: 10px;
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
<body ng-app="orderApp" ng-controller="OrderDetailController">
<div class="container mt-4">
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" href="/order-history">Tất cả</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/order-history/status?status=0">Chờ xác nhận</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/order-history/status?status=1">Chờ giao hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/order-history/status?status=2">Đang giao hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/order-history/status?status=3">Hoàn thành</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/order-history/status?status=4">Đã hủy</a>
                </li>
            </ul>
        </div>
    </nav>

    <h3 class="mb-4" style="margin-top: 20px">🛒 Lịch sử đơn hàng</h3>
    <c:forEach var="item" items="${hd}">
        <div class="order-container">
            <div class="order-header">
                <div class="order-status">${item.trangThai}</div>
            </div>
            <c:forEach items="${item.hoaDonChiTiets}" var="hdct">
                <div class="order-item"
                     data-color-id="${hdct.quanJeansChiTiet.mauSac.id}"
                     data-product-id="${hdct.quanJeansChiTiet.quanJeans.id}"
                     data-hdct-id="${hdct.id}">
                    <img ng-src="{{ imageUrls[${hdct.id}]}}" alt="Product">
                    <div class="order-item-info">
                        <strong>${ hdct.quanJeansChiTiet.quanJeans.tenSanPham }</strong>
                        <p class="text-muted">Phân
                            loại: ${ hdct.quanJeansChiTiet.mauSac.tenMauSac }, ${ hdct.quanJeansChiTiet.size.tenSize }</p>
                        <p class="text-muted">Số lượng: ${hdct.soLuong}</p>
                        <p class="order-price">
                            Đơn giá:
                            <fmt:formatNumber value="${hdct.donGia}" type="currency" currencySymbol="VND"
                            />
                        </p>
                    </div>
                </div>
            </c:forEach>
            <p class="order-price" style="margin-top: 20px">
                Tổng tiền:
                <fmt:formatNumber value="${item.tongTien}" type="currency" currencySymbol="VND"
                />
            </p>
            <p class="order-price">
                Phí ship:
                <fmt:formatNumber value="${item.phiShip}" type="currency" currencySymbol="VND"
                />
            </p>
            <p class="order-price">
                Giảm giá:
                <fmt:formatNumber value="${item.giamGia}" type="currency" currencySymbol="VND"
                />
            </p>
            <div class="order-footer">
                <div style="font-weight: bold;font-size: 20px">
                    Thành tiền:
                    <fmt:formatNumber value="${item.thanhTien}" type="currency" currencySymbol="VND"/>
                </div>
                <c:if test="${item.trangThai=='Chờ xác nhận'}">
                    <button class="btn btn-danger" style="width: 120px" ng-click="setTTHuy(${item.id})">Hủy</button>
                </c:if>
                <c:if test="${item.trangThai=='Đang giao hàng'}">
                    <button class="btn btn-primary" ng-click="setTTHoanThanh(${item.id})">Đã nhận được hàng</button>
                </c:if>
            </div>
        </div>
    </c:forEach>


</div>
</div>


</body>
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