<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background: linear-gradient(to bottom, #E3F2FD, #BBDEFB);
        }
        .login-container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
            overflow: visible;
        }
        .avatar-container {
            position: absolute;
            top: -60px;
            left: 50%;
            transform: translateX(-50%);
            background: white;
            width: 130px;
            height: 130px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
        }
        .form-group {
            position: relative;
        }
        .form-group input {
            padding-right: 40px;
        }
        .form-group .icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: gray;
        }
        input:focus::placeholder {
            color: transparent;
        }
        /* Bỏ gạch chân của link */
        .no-underline {
            text-decoration: none;
        }
    </style>
</head>
<body>

<section class="vh-100 d-flex justify-content-center align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4 position-relative">
                <div class="login-container">
                    <div class="avatar-container">
                        <img src="https://file.hstatic.net/200000962346/file/icon_admin.webp"
                             alt="Avatar" class="avatar">
                    </div>
                    <h2 class="text-primary mb-4 mt-5">Login with Admin</h2>
                    <form action="/login/admin" method="POST">
                        <div class="mb-3 form-group">
                            <input type="email" name="email" class="form-control" placeholder="Enter your email">
                            <i class="bi bi-envelope icon"></i>
                        </div>
                        <div class="mb-3 form-group">
                            <input type="password" name="password" class="form-control" placeholder="Enter your password">
                            <i class="bi bi-lock icon"></i>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <a href="#" class="text-primary no-underline">Forgot password?</a>
                            <a href="/intro" class="text-secondary no-underline">Back to</a>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Sign in</button>
                    </form>
                    <p style="color: red;">${error}</p>

                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
