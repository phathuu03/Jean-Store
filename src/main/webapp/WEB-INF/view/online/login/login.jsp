<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Jeans Store</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            height: 100vh;
        }

        .login-container {
            max-width: 420px;
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
            border-radius: 8px;
            height: 50px;
            font-size: 16px;
        }

        .forgot-password {
            font-size: 15px;
            color: #0984e3;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<header class="p-3 bg-dark text-white fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold">
                <i class="bi bi-bag"></i> Jeans Store
            </a>
        </div>
    </nav>
</header>

<section class="d-flex align-items-center justify-content-center vh-100">
    <div class="login-container">
        <h2 class="text-center mb-4 fw-bold">Đăng Nhập</h2>

        <form action="#" method="">
            <div class="form-floating mb-4">
                <input type="text" id="username" class="form-control" name="username" required />
                <label for="username"><i class="bi bi-person"></i> Tên đăng nhập</label>
            </div>

            <div class="form-floating mb-4">
                <input type="password" id="password" class="form-control" name="password" required />
                <label for="password"><i class="bi bi-lock"></i> Mật khẩu</label>
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe" />
                    <label class="form-check-label" for="rememberMe"> Ghi nhớ đăng nhập </label>
                </div>
                <a href="#" class="forgot-password" style="margin: 20px">Quên mật khẩu?</a>
            </div>

            <button class="btn btn-login w-100 fw-bold" type="submit">
                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
            </button>

            <hr class="my-4">
        </form>
    </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

</body>
</html>
