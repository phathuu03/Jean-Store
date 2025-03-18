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
    <script src="${pageContext.request.contextPath}/js/home.js"></script>

</head>
<style>
    .search-container {
        width: 100%;
        display: flex;
        justify-content: center;
        margin-top: -30px; /* Đẩy lên gần banner */
    }

    .search-form {
        background: white;
        border-radius: 25px;
        padding: 5px 10px;
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        width: 50%;
        display: flex;
        align-items: center;
    }

    .search-input {
        border: none;
        outline: none;
        flex: 1;
        padding: 10px 15px;
        border-radius: 25px;
        font-size: 16px;
    }

    .search-btn {
        background: #007bff;
        color: white;
        border: none;
        border-radius: 50%;
        padding: 8px 12px;
        transition: 0.3s;
    }

    .search-btn:hover {
        background: #0056b3;
    }

</style>
<body style="background-color: aliceblue">
<header class="p-3 bg-dark text-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between">
            <!-- Logo -->
            <a class="navbar-brand fw-bold text-primary d-flex align-items-center" href="/home">
                <i class="bi bi-bag me-2"></i> Jeans Store
            </a>

            <!-- Menu -->
            <ul class="nav col-lg-auto mb-2 mb-lg-0">
                <li><a href="/home" class="nav-link px-3 text-white">Trang chủ</a></li>
                <li><a href="/order-history" class="nav-link px-3 text-white">Quản lý đơn hàng</a></li>
                <li><a href="/cart/detail" class="nav-link px-3 text-white">Giỏ hàng</a></li>
                <li><a href="/user/detail" class="nav-link px-3 text-white">Tài khoản</a></li>
            </ul>

            <!-- Đăng nhập / Chào mừng -->
            <div class="d-flex align-items-center">
                <a href="/online/login" id="btnLogin" class="btn btn-outline-light me-3">Đăng nhập</a>
                <p id="textWelcome" class="mb-0 fw-bold text-light" style="display: none;"></p>
            </div>
        </div>
    </div>
</header>

<div class="banner d-flex justify-content-center">
    <img src="${pageContext.request.contextPath}/image/bannerJeans.png"
         class="img-fluid mt-3" style="max-width: 100%;">
</div>

<div ng-app="myApp" ng-controller="HomeController" class="content" style="margin-top: 50px;margin-left: 100px">
    <div class="search-container d-flex justify-content-center mt-3">
        <form action="/onl-search" method="GET" class="search-form d-flex">
            <input class="form-control search-input" type="text" name="query" placeholder="Tìm kiếm sản phẩm..."
                   aria-label="Search">
            <button class="btn search-btn" type="submit">
                <i class="bi bi-search"></i>
            </button>
        </form>
    </div>
    <div class="container" style="margin: 40px;">
        <div class="row">
            <!-- Danh sách tên sản phẩm -->
            <div class="col-md-3 border fixed-sidebar">
                <h5 class="text-center">Thương Hiệu</h5>
                <hr>
                <c:forEach var="item" items="${thuongHieu}">
                    <a href="/home/thuonghieu?id=${item[1]}" class="product-link">${item[0]}</a><br>
                </c:forEach>
                <h5 class="text-center">Chất liệu</h5>
                <hr>
                <c:forEach var="chatLieu" items="${chatLieu}">
                    <a href="/home/chatlieu?id=${chatLieu[1]}" class="product-link">${chatLieu[0]}</a><br>
                </c:forEach>
                <h5 class="text-center">Ống Quần</h5>
                <hr>
                <c:forEach var="ongQuan" items="${ongQuan}">
                    <a href="/home/ongquan?id=${ongQuan[1]}" class="product-link">${ongQuan[0]}</a><br>
                </c:forEach>
            </div>
            <!-- Danh sách hình ảnh sản phẩm -->
            <div class="col-md-9">
                <div class="row row-cols-1 row-cols-md-4 g-4" style="margin-top: 200px;margin-left: 500px;font-weight: bold">
                    Không tìm thấy sản phẩm nào.
                </div>
            </div>

        </div>

        <div class="footer">
            <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
                <div class="col-md-4 d-flex align-items-center">
                    <a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                        <svg class="bi" width="30" height="24">
                            <use xlink:href="#bootstrap"></use>
                        </svg>
                    </a>
                    <span class="text-muted">© 2025 Company, Jeans Store</span>
                </div>

                <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">

                </ul>
            </footer>
        </div>
    </div>
</div>
</body>
<script>

</script>
</html>