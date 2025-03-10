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
    <script src="${pageContext.request.contextPath}/js/user.js"></script>

</head>
<style>
    .footer {
        color: white;
        text-align: center;
        padding: 10px 0;
        width: 100%;
    }

    .profile-container {
        max-width: 600px;
        margin: 50px auto;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .profile-image img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: #eaeaea;
    }
</style>
<body style="background-color: aliceblue">
<header class="p-3 bg-dark text-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <div class="d-flex align-items-center mb-2 mb-lg-0 text-red text-decoration-none"
                 style="color: cornflowerblue">
                <a class="navbar-brand fw-bold" href="/home">
                    <i class="bi bi-bag"></i> Jeans Store
                </a>
            </div>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/home" class="nav-link px-2 text-white">Trang chủ</a></li>
                <li><a href="/order-history" class="nav-link px-2 text-white">Quản lý đơn hàng</a></li>
                <li><a href="/cart/detail" class="nav-link px-2 text-white">Giỏ hàng</a></li>
                <li><a href="/user/detail" class="nav-link px-2 text-white">Tài khoản</a></li>
            </ul>
            <div class="text-end">
                <a href="/online/login" type="button" class="btn btn-outline-light me-2">Đăng nhập</a>
            </div>
        </div>
    </div>
</header>
<body ng-app="myApp" ng-controller="UserController">
<div class="profile-container">
    <h4 class="text-center">Tài Khoản Của Tôi</h4>
    <div class="mb-3">
        <label class="form-label">Tên đăng nhập</label>
        <input type="text" class="form-control" value="${user.tenDangNhap}" disabled>
    </div>
    <div class="mb-3">
        <label class="form-label">Mật khẩu</label>
        <input type="password" class="form-control" id="password" value="${user.matKhau}" disabled>
        <a href="#" data-bs-toggle="modal" data-bs-target="#changePasswordModal" class="text-danger smal">Thay đổi mật khẩu</a>
    </div>
    <div class="mb-3">
        <label class="form-label">Tên</label>
        <input type="text" class="form-control" id="name" name="fullname" value="${user.tenKhachHang}" required>
        <p class="text-danger" ng-if="checkError.name">{{mes.name}}</p>
    </div>
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="email" class="form-control" id="email" value="${user.email}" required>
        <p class="text-danger" ng-if="checkError.email">{{mes.email}}</p>
    </div>
    <div class="mb-3">
        <label class="form-label">Số điện thoại</label>
        <input type="text" class="form-control" value="${user.soDienThoai}" disabled>
    </div>
    <div class="mb-3">
        <label class="form-label">Giới tính</label><br>
        <input type="radio" name="gender" value="true" ${user.gioiTinh==true?'checked':""}> Nam
        <input type="radio" name="gender" value="false" ${user.gioiTinh==false?'checked':""}> Nữ
    </div>
    <div class="mb-3">
        <label class="form-label">Địa chỉ nhận hàng</label>
        <input type="text" id="address" class="form-control" value="${user.diaChi}" required>
        <p class="text-danger" ng-if="checkError.address">{{mes.address}}</p>

    </div>

    <button ng-click="updateUser()" type="submit" class="btn btn-primary w-100"
            style="margin-bottom: 20px;margin-top: 20px">Lưu
    </button>
    <a href="/logout" type="submit" class="btn btn-danger w-100">Đăng xuất</a>

    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Thay Đổi Mật Khẩu</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu hiện tại</label>
                        <input type="text" class="form-control" id="currentPassword" required>
                        <p class="text-danger" ng-if="check.passwordCurrent">{{mes.passwordCurrent}}</p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới</label>
                        <input type="text" class="form-control" id="newPassword" required>
                        <p class="text-danger" ng-if="check.passwordNew">{{mes.passwordNew}}</p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="text" class="form-control" id="confirmPassword" required>
                        <p class="text-danger" ng-if="check.passwordConfirm">{{mes.passwordConfirm}}</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" ng-click="changePassword()">Xác nhận</button>
                </div>
            </div>
        </div>
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