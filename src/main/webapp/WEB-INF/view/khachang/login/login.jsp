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
            text-align: center;
            position: relative;
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
            margin-bottom: 25px;
        }
        .form-group input {
            padding-right: 40px; /* Dành chỗ cho icon */
            height: 45px;
        }
        /* Sửa icon cố định theo input */
        .form-group .icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: gray;
            font-size: 18px;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
            display: flex;
            align-items: center;
        }
        .error-message i {
            margin-right: 5px;
        }
        input:focus::placeholder {
            color: transparent;
        }
        .no-underline {
            text-decoration: none;
        }
    </style>
</head>
<body>

<section class="vh-100 d-flex justify-content-center align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="login-container">
                    <div class="avatar-container">
                        <img src="https://file.hstatic.net/200000962346/file/icon_admin.webp"
                             alt="Avatar" class="avatar">
                    </div>
                    <h2 class="text-primary mb-4 mt-5">Login</h2>
                    <form action="/login" method="POST">
                        <div class="mb-3 form-group">
                            <input type="email" name="email" class="form-control" placeholder="Enter your email" value="${email}">
                            <i class="bi bi-envelope icon"></i>
                            <c:if test="${not empty errorEmail}">
                                <p class="error-message"> ${errorEmail}</p>
                            </c:if>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="password" name="password" class="form-control" placeholder="Enter your password">
                            <i class="bi bi-lock icon"></i>
                            <c:if test="${not empty errorPassword}">
                                <p class="error-message"> ${errorPassword}</p>
                            </c:if>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <a href="#" class="text-primary no-underline">Forgot password?</a>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Sign in</button>

                        <p class="mt-3">Don't have an account? <a href="/register" class="text-primary">Register</a></p>
                    </form>


                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
