<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Jeans Store</title>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://code.angularjs.org/1.8.2/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular-route.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


    <style>
        body {
            background: aliceblue;
            height: 100vh;
        }

        .login-container {
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
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
    </style>
</head>

<body ng-app="myApp" ng-controller="LoginController">

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
    <div class="login-container">
        <h2 class="text-center mb-4 fw-bold">Đăng Nhập</h2>

        <c:if test="${param.error != null}">
            <p style="color: red;">Sai tài khoản hoặc mật khẩu!</p>
        </c:if>
        <c:if test="${param.logout != null}">
            <p style="color: green;">Bạn đã đăng xuất thành công!</p>
        </c:if>
        <form action="" method="post">
            <div class="form-floating mb-4">
                <input type="text" id="username" class="form-control" name="username" required/>
                <label for="username"><i class="bi bi-person"></i> Tên đăng nhập</label>
            </div>

            <div class="form-floating mb-4">
                <input type="password" id="password" class="form-control" name="password" required/>
                <label for="password"><i class="bi bi-lock"></i> Mật khẩu</label>
                <button type="button" class="toggle-password" onclick="togglePassword()">
                    <i id="eyeIcon" class="fa-solid fa-eye"></i>
                </button>
            </div>
            <div style="margin-bottom: 10px"><a class="text-primary" href="/forgot-password" id="forgot"
                    style="text-decoration: none;margin: 10px 10px 20px;color: #dd4b39;font-weight: bold">Quên mật khẩu?</a>
            </div>

            <a class="text-primary" href="/online/register" id="mess"
               style="text-decoration: none;margin: 10px;color: #dd4b39;font-weight: bold">Bạn
                chưa có tài khoản đăng ký ngay ?</a>

            <button id="btnLogin" class="btn btn-login w-100 fw-bold" style="margin-top: 20px" type="submit">
                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
            </button>
            <hr class="my-4">
        </form>
    </div>
</section>
<script>
    function togglePassword() {
        var passwordInput = document.getElementById("password");
        var eyeIcon = document.getElementById("eyeIcon");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIcon.classList.remove("fa-eye");
            eyeIcon.classList.add("fa-eye-slash");
        } else {
            passwordInput.type = "password";
            eyeIcon.classList.remove("fa-eye-slash");
            eyeIcon.classList.add("fa-eye"); // Đổi sang icon mắt mở
        }
    }
</script>

</body>
</html>
