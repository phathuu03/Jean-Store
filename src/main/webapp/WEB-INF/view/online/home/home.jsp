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
</head>
<body style="background-color: aliceblue">
<header class="p-3 bg-dark text-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <div class="d-flex align-items-center mb-2 mb-lg-0 text-red text-decoration-none"
                 style="color: cornflowerblue">
                <a class="navbar-brand fw-bold" href="/home">
                    <i class="bi bi-bag"></i> Jeans Store
                </a></div>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/home" class="nav-link px-2 text-white">Trang chủ</a></li>
                <li><a href="/order-history" class="nav-link px-2 text-white">Quản lý đơn hàng</a></li>
                <li><a href="/cart/detail" class="nav-link px-2 text-white">Giỏ hàng</a></li>
                <li><a href="/user/detail" class="nav-link px-2 text-white">Tài khoản</a></li>
            </ul>


            <div class="text-end">
                <a href="/online/login" type="button" class="btn btn-outline-light me-2">Đăng nhập</a>
            </div>
        </div>
    </div>
</header>
<div class="banner d-flex justify-content-center">
    <img src="${pageContext.request.contextPath}/image/bannerJeans.png"
         class="img-fluid mt-3" style="max-width: 100%;">
</div>
<div ng-app="myApp" class="content" style="margin-top: 50px;margin-left: 100px">
    <div class="container" style="margin: 40px;">
        <div class="row">
            <!-- Danh sách tên sản phẩm -->
            <div class="col-md-3 border fixed-sidebar">
                <h5 class="text-center">Thương Hiệu</h5>
                <hr>
                <c:forEach var="item" items="${thuongHieu}">
                    <a href="/home/thuonghieu?id=${item.id}" class="product-link">${item.tenThuongHieu}</a><br>
                </c:forEach>
                <h5 class="text-center">Chất liệu</h5>
                <hr>
                <c:forEach var="chatLieu" items="${chatLieu}">
                    <a href="/home/chatlieu?id=${chatLieu.id}" class="product-link">${chatLieu.tenChatLieu}</a><br>
                </c:forEach>
                <h5 class="text-center">Ống Quần</h5>
                <hr>
                <c:forEach var="ongQuan" items="${ongQuan}">
                    <a href="/home/ongquan?id=${ongQuan.id}" class="product-link">${ongQuan.tenOngQuan}</a><br>
                </c:forEach>
            </div>
            <!-- Danh sách hình ảnh sản phẩm -->
            <div class="col-md-9">
                <div class="row row-cols-1 row-cols-md-4 g-4">
                    <c:forEach var="item1" items="${quanJeans}">
                        <div class="col">
                            <div class="card h-100 product-card shadow-sm">
                                <div class="d-flex justify-content-center align-items-center p-3 bg-light"
                                     style="height: 200px;">
                                    <c:forEach var="hinhAnh" items="${item1.hinhAnh}" begin="0" end="0">
                                        <img src="${hinhAnh.url}" alt="Hình ảnh sản phẩm" class="img-fluid product-img">
                                    </c:forEach>
                                </div>
                                <div class="card-body text-center">
                                    <c:forEach var="quanCT" items="${item1.quanJeansChiTiets}" begin="0" end="0">
                                        <p class="text-danger fw-bold">
                                            <fmt:formatNumber value="${quanCT.gia}" type="currency" currencySymbol="đ"/>
                                        </p>
                                    </c:forEach>
                                    <a href="/home/product-detail?id=${item1.id}"
                                       class="text-dark fw-semibold text-decoration-none d-block">
                                            ${item1.tenSanPham}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <nav aria-label="Page navigation" style="margin-top: 20px">
                    <ul class="pagination justify-content-center">
                        <!-- Nút "Trước" -->
                        <c:if test="${currentPage > 0}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage - 1}&size=12"
                                   style="color: black;font-weight: bold">« Trước</a>
                            </li>
                        </c:if>

                        <!-- Danh sách số trang -->
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&size=12"
                                   style="color: black;font-weight: bold">${i + 1}</a>
                            </li>
                        </c:forEach>

                        <!-- Nút "Tiếp" -->
                        <c:if test="${currentPage + 1 < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&size=12"
                                   style="color: black;font-weight: bold">Tiếp »</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
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
</body>
<script>

</script>
</html>