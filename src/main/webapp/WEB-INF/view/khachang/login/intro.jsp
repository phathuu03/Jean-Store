<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Jeans Store</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://code.angularjs.org/1.8.2/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular-route.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
<style>
    footer {
        background-color: #C4A484; /* Màu be nhạt */
        padding: 20px;
    }

    footer a {
        transition: color 0.3s ease, font-weight 0.3s ease;
    }

    footer a:hover {
        color: #0056b3; /* Màu xanh đậm hơn */
        font-weight: bold;
    }

    footer .bi {
        transition: transform 0.3s ease, color 0.3s ease;
    }

    footer .bi:hover {
        transform: scale(1.2);
        color: #0056b3;
    }
</style>

</head>
<body style="background-color: aliceblue">
<header class="p-3 bg-dark text-white shadow">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark container">

        <a class="navbar-brand d-flex align-items-center" href="/intro">
             Jeans Store
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="/login" class="btn btn-outline-light">Login</a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<div class="banner text-center">
    <img src="https://file.hstatic.net/200000962346/file/banner_jeans_store.jpg" class="img-fluid rounded shadow">
</div>

<div ng-app="myApp" class="content container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <h2 class="fw-bold">Chào mừng đến với Jeans Store</h2>
            <p class="text-muted">Khám phá bộ sưu tập quần jeans phong cách dành cho bạn!</p>
        </div>
    </div>
</div>

<footer class="bg-light text-dark py-5">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h6 class="fw-bold">Mua sắm</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-dark text-decoration-none">Giao hàng</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Thanh toán</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Trả hàng</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Tìm cửa hàng</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Magazine</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h6 class="fw-bold">Thông tin doanh nghiệp</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-dark text-decoration-none">Cơ hội nghề nghiệp</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Giới thiệu về Jeans Store</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Thời trang bền vững</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Báo chí</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Quan hệ với nhà đầu tư</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Quản trị doanh nghiệp</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h6 class="fw-bold">Trợ giúp</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-dark text-decoration-none">Dịch vụ khách hàng</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Tài khoản của tôi</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Điều khoản & điều kiện</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Pháp lý & bảo mật</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Liên hệ</a></li>
                    <li><a href="#" class="text-dark text-decoration-none">Chính sách bảo mật thanh toán</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h6 class="fw-bold">Tham gia ngay</h6>
                <p>Trở thành thành viên của Jeans Store để nhận ưu đãi 10% cho lần mua tiếp theo!</p>
                <a href="#" class="fw-bold text-decoration-none text-primary">Đọc thêm →</a>
            </div>
        </div>

        <div class="text-center my-4">
            <a href="#" class="mx-2 text-dark"><i class="bi bi-instagram"></i></a>
            <a href="#" class="mx-2 text-dark"><i class="bi bi-tiktok"></i></a>
            <a href="#" class="mx-2 text-dark"><i class="bi bi-facebook"></i></a>
            <a href="#" class="mx-2 text-dark"><i class="bi bi-youtube"></i></a>
            <a href="#" class="mx-2 text-dark"><i class="bi bi-pinterest"></i></a>
        </div>

        <div class="text-center">
            <p class="mt-2 text-muted">&copy; 2025 Jeans Store. All rights reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>