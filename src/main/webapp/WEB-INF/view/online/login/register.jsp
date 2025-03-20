<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Jeans Store</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://code.angularjs.org/1.8.2/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular-route.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

</head>
<style>
    body {
        background: aliceblue;
        height: 100vh;
    }

    .btn-login {
        background-color: #0984e3;
        color: white;
        font-size: 18px;
        padding: 12px;
        border-radius: 8px;
        transition: 0.3s;
    }

    .btn-login:hover {
        background-color: #0a67b1;
    }

    .form-floating input {
        width: 500px;
        border-radius: 8px;
        height: 50px;
        font-size: 16px;
    }
    .password-wrapper {
        position: relative;
    }

    .toggle-password {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        cursor: pointer;
        font-size: 18px;
        color: #666;
    }

    .toggle-password:focus {
        outline: none;
    }
    .error-message {
        font-size: 14px;
        color: red;
        margin-top: 5px;
        max-width: 500px;
        word-wrap: break-word;
        white-space: normal;
    }

</style>
<body ng-app="myApp" ng-controller="RegisterController">

<header class="p-3 bg-dark text-white fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" style="color: cornflowerblue" href="/home">
                <i class="bi bi-bag"></i> Jeans Store
            </a>
        </div>
    </nav>
</header>

<section class="d-flex align-items-center justify-content-center vh-100">
    <div class="register-container">
        <h2 class="text-center mb-4 fw-bold">Đăng Ký</h2>

        <div class="form-floating mb-4">
            <input type="text" id="name" class="form-control" name="name" required/>
            <label for="name"><i class=""></i> Họ tên</label>
            <p class="text-danger" ng-if="check.name">{{mes.name}}</p>
        </div>
        <div class="form-floating mb-4">
            <input type="text" id="username" class="form-control" name="username" required/>
            <label for="username"><i class=""></i> Tên đăng nhập</label>
            <p class="text-danger" ng-if="check.username">{{mes.username}}</p>
        </div>
        <div class="form-floating mb-4 password-wrapper">
            <input type="password" id="password" class="form-control" name="password" required/>
            <label for="password"> Mật khẩu</label>
            <button type="button" class="toggle-password" onclick="togglePassword()">
                <i id="eyeIcon" class="fa-solid fa-eye"></i>
            </button>
            <p class="text-danger error-message" ng-if="check.password">{{mes.password}}</p>
        </div>
        <div class="form-floating mb-4">
            <input type="password" id="passwordConfirm" class="form-control" name="passwordConfirm" required/>
            <label for="passwordConfirm"><i class=""></i>Xác nhận Mật khẩu</label>
            <button type="button" class="toggle-password" onclick="togglePasswordConfirm()">
                <i id="eyeIconConfirm" class="fa-solid fa-eye"></i>
            </button>
            <p class="text-danger" ng-if="check.passwordConfirm">{{mes.passwordConfirm}}</p>
        </div>
        <div class="form-floating mb-4">
            <input type="text" id="sdt" class="form-control" name="sdt" required/>
            <label for="sdt"><i class=""></i> Số điện thoại</label>
            <p class="text-danger" ng-if="check.sdt">{{mes.sdt}}</p>

        </div>

        <div class="form-floating mb-4">
            <input type="text" id="email" class="form-control" name="email" required/>
            <label for="email"><i class=""></i> Email</label>
            <p class="text-danger" ng-if="check.email">{{mes.email}}</p>
        </div>
        <div class="mb-4">
            <label class="form-label">Giới tính</label><br>
            <input type="radio" name="gender" value="true" checked> Nam
            <input type="radio" name="gender" value="false"> Nữ
        </div>

        <button class="btn btn-login w-100 fw-bold" ng-click="registerUser()" style="margin-top: 20px" type="submit">
            <i class="bi bi-box-arrow-in-right"></i> Đăng ký
        </button>
        <hr class="my-4">
    </div>
</section>
<script>
    function togglePassword() {
        var passwordInput = document.getElementById("password");
        var eyeIcon = document.getElementById("eyeIcon");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIcon.classList.remove("fa-eye");
            eyeIcon.classList.add("fa-eye-slash"); // Đổi sang icon mắt đóng
        } else {
            passwordInput.type = "password";
            eyeIcon.classList.remove("fa-eye-slash");
            eyeIcon.classList.add("fa-eye"); // Đổi sang icon mắt mở
        }
    }

    function togglePasswordConfirm() {
        var passwordInput = document.getElementById("passwordConfirm");
        var eyeIconConfirm = document.getElementById("eyeIconConfirm");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIconConfirm.classList.remove("fa-eye");
            eyeIconConfirm.classList.add("fa-eye-slash"); // Đổi sang icon mắt đóng
        } else {
            passwordInput.type = "password";
            eyeIconConfirm.classList.remove("fa-eye-slash");
            eyeIconConfirm.classList.add("fa-eye"); // Đổi sang icon mắt mở
        }
    }

</script>
</body>
</html>
