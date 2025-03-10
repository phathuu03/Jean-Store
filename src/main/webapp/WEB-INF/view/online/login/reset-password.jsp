<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html ng-app="myApp" ng-controller="ForgotController">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Jeans Store</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular-route.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/forgot-password.js"></script>

    <style>
        body {
            background: #f8f9fa;
        }
        .login-container {
            max-width: 450px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
        }
        .form-floating input {
            border-radius: 5px;
        }
        .navbar-brand {
            color: #f8f9fa !important;
        }
    </style>
</head>
<body>
<header class="p-3 bg-dark text-white fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="/home">
                <i class="bi bi-bag"></i> Jeans Store
            </a>
        </div>
    </nav>
</header>

<section class="d-flex align-items-center justify-content-center vh-100">
    <div class="login-container">
        <h2 class="text-center mb-4 fw-bold">Thay Đổi Mật Khẩu</h2>
        <form>
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
            <button type="button" class="btn btn-primary w-100 fw-bold" ng-click="changePassword()">Xác nhận</button>
        </form>
    </div>
</section>
</body>
</html>