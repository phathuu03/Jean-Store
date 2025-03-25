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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <script src="${pageContext.request.contextPath}/js/order.js"></script>

</head>
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

<div class="container mt-4" ng-app="myApp" ng-controller="OrderController">
    <h4 class="fw-bold text-primary">🚚 Địa chỉ giao hàng</h4>

    <div class="border rounded p-3 bg-white shadow-sm">
        <p class="mb-1"><strong class="text-dark">{{user.tenKhachHang}}</strong> - {{user.soDienThoai}}</p>
        <p class="text-muted mb-1" id="address">{{user.diaChi +" - "+ user.phuongXa +" - "+ user.quanHuyen +" - "+ user.tinhTP}}</p>
        <a href="#" data-bs-toggle="modal" data-bs-target="#changeAddress" class="text-danger smal">Thay đổi địa chỉ</a>
    </div>

    <div class="border rounded p-3 bg-white shadow-sm" style="margin-top: 30px">
        <div class="d-flex align-items-center border-bottom py-3" ng-repeat="item in cart">
            <img ng-src="{{item.image}}" alt="Product Image" class="rounded border" width="100">

            <div class="ms-3 flex-grow-1">
                <span class="badge bg-warning text-dark fs-6 p-2">{{item.name}}</span>
                <p class="mb-1 text-muted"><strong>Màu:</strong> {{item.color}} | <strong>Size:</strong> {{item.size}}
                </p>
            </div>

            <div class="ms-3 text-end">
                <p class="mb-1 text-muted"><strong>Giá:</strong> {{item.price | number:0 }} VND</p>
                <p class="mb-1 text-muted"><strong>Số lượng:</strong> {{item.quantity}}</p>
            </div>

            <div class="ms-3 text-end">
                <p class="mb-0 text-danger fw-bold">Thành tiền: {{item.price * item.quantity | number:0 }} VND</p>
            </div>
        </div>
    </div>

    <h5 class="mt-3 text-end fw-bold text-primary">
        Tổng Tiền: <span class="text-danger fs-4">{{sumPriceCart | number:0 }} VND</span>
    </h5>

    <h4 class="mt-4 text-success">🎁 Áp dụng khuyến mãi</h4>
    <select class="form-select" ng-model="selectedVoucher"
            ng-change="setMoney(selectedVoucher.giamGiaToiDa,selectedVoucher.phanTramGiamGia)">
        <option ng-repeat="item in voucher" ng-value="item">{{item.tenVoucher}}</option>
    </select>

    <h4 class="mt-4 fw-bold">🛒 Thông tin đơn hàng</h4>
    <div class="border rounded p-3 bg-white shadow-sm">
        <p>🛍️ Tạm tính ({{cart.length}} sản phẩm) <span
                class="float-end text-muted">{{sumPriceCart | number:0 }} VND</span></p>
        <p>🚚 Phí vận chuyển <span class="float-end text-success" id="ship">+ {{ship | number:0 }} VND</span></p>
        <hr>
        <p>💲 Giảm giá <span class="float-end text-success"> - {{moneyIsReduced | number:0 }} VND</span></p>
        <hr>
        <p><strong>💳 Tổng cộng:</strong> <span
                class="float-end text-danger fs-4 fw-bold">{{moneySum | number:0 }} VND</span>
        </p>
        <h5 class="mt-3 text-primary">💰 Chọn phương thức thanh toán</h5>
        <select class="form-select" ng-model="selectedPaymentMethod" ng-change="onPaymentMethodChange()">
            <c:forEach var="item" items="${pttt}">
                <option value="${item.id}">${item.tenPTTT}</option>
            </c:forEach>
        </select>
        <a class="btn btn-success w-100 mt-3" ng-click="checkout()">🛍️ Đặt hàng ngay</a>
    </div>
    <div class="modal fade" id="changeAddress" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Header -->
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalTitleAdress">Thay Đổi Địa Chỉ</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- Body -->
                <div class="modal-body">
                    <h6 class="text-center mb-3">Chọn địa chỉ giao hàng</h6>
                    <form>
                        <!-- Tỉnh / Thành phố -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tỉnh / TP</label>
                            <select id="province" name="province" class="form-select"
                                    ng-model="selectedProvince"
                                    ng-options="item.ProvinceID as item.ProvinceName for item in provinces1"
                                    ng-change="onProvinceChange(selectedProvince)">
                                <option value="">Chọn tỉnh</option>
                            </select>
                        </div>

                        <!-- Quận / Huyện -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Quận / Huyện</label>
                            <select id="districts" name="districts" class="form-select"
                                    ng-model="selectedDistricts"
                                    ng-options="item.DistrictID as item.DistrictName for item in districts1"
                                    ng-change="onDistrictsChange(selectedDistricts)">
                                <option value="">Chọn huyện</option>
                            </select>
                        </div>

                        <!-- Phường / Xã -->
                        <!-- Quận / Huyện -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Phường / Xã</label>
                            <select id="wards" name="wards" class="form-select"
                                    ng-model="selectedWards"
                                    ng-options="item.WardCode as item.WardName for item in wards1">
                                <option value="">Chọn xã</option>
                            </select>
                        </div>
                        <!-- Địa chỉ cụ thể -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ cụ thể</label>
                            <input type="text" class="form-control" id="addressDetail"
                                   placeholder="Nhập số nhà, tên đường..." required>
                        </div>
                    </form>
                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" ng-click="changeAddress()">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
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