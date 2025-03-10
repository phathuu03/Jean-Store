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
    <script src="${pageContext.request.contextPath}/js/forgot-password.js"></script>
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
    </style>
</head>

<body ng-app="myApp" ng-controller="ForgotController">

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
        <h2 class="text-center mb-4 fw-bold">Quên mật khẩu</h2>
            <div class="form-floating mb-4">
                <input type="text" id="username" class="form-control" name="username" required/>
                <label for="username"><i class="bi bi-person"></i> Tên đăng nhập</label>
            </div>

            <div class="form-floating mb-4">
                <input type="text" id="email" class="form-control" name="email" required/>
                <label for="email"></i> Email</label>
            </div>

            <button ng-click="sendEmail()" class="btn btn-login w-100 fw-bold" style="margin-top: 20px" type="submit">
                <i  class="bi bi-box-arrow-in-right"></i> Gửi
            </button>
            <hr class="my-4">
    </div>
</section>
<section class="d-flex align-items-center justify-content-center vh-100">
    <div class="login-container">

    </div>
</section>
</body>
</html>
