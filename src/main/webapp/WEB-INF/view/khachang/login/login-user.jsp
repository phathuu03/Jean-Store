<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">

    <style>
        body {
            background: linear-gradient(to bottom, #E3F2FD, #BBDEFB);
        }
        .login-container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            position: relative;
        }
        .form-group input {
            padding-right: 40px; /* Chừa khoảng trống cho icon */
        }
        .form-group .icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: gray;
        }
        input:focus::placeholder {
            color: transparent; /* Ẩn placeholder khi focus */
        }
    </style>
</head>
<body>

<section class="vh-100 d-flex justify-content-center align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="login-container text-center">
                    <h1 class="text-primary mb-4">Login</h1>

                    <form action="/login/user" method="POST">
                        <div class="mb-3 form-group">
                            <input type="email" name="email" class="form-control" placeholder="Enter your email" value="${email}">
                            <i class="bi bi-envelope icon"></i>
                            <p style="color: red; margin-top: 5px;">${errorEmail}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="password" name="password" class="form-control" placeholder="Enter your password">
                            <i class="bi bi-lock icon"></i>
                            <p style="color: red; margin-top: 5px;">${errorPassword}</p>
                        </div>

                        <div class="d-flex justify-content-between mb-3">
                            <a href="#" class="text-primary">Forgot password?</a>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Sign in</button>

                        <p class="mt-3">Don't have an account? <a href="/register" class="text-primary">Register</a></p>

                        <p style="color: red; text-align: center; margin-top: 10px;">${loginError}</p>
                    </form>

                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
