<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            overflow-x: hidden;
        }

        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 1000;
            padding: 20px 0;
            background-color: #B0A1A1; /* Đã tối hơn */
            width: 250px;
            text-align: left;
        }

        .sidebar-logo img {
            width: 180px;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        .main-title {
            font-size: 24px;
            font-weight: bold;
            color: #1F3A5F;
            margin-left: 20px;
        }

        .nav-link {
            color: white !important;
            font-weight: bold;
            display: flex;
            align-items: center;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .nav-link i {
            margin-right: 10px;
        }

        .nav-link:hover {
            background-color: #d4c6a6;
        }

        .main-content {
            margin-left: 250px;
            padding: 40px 20px 20px;
        }

        .content-frame {
            width: 100%;
            height: calc(100vh - 50px);
            border: none;
        }

        .nav-item {
            border-bottom: 1px solid #e0e0e0;
            padding: 5px 0;
        }

        .nav-link.active {
            background-color: #6c757d;
            color: #fff !important;
            font-weight: bold;
        }

        .submenu {
            display: none;
            padding-left: 20px;
        }

        .submenu a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 5px 0;
        }

        .triangle-icon {
            font-size: 10px;
            margin-left: 5px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 p-3 sidebar">
            <div class="sidebar-logo">
                <img src="https://file.hstatic.net/200000962346/file/snapbg.ai_1739957977396.png"
                     alt="Jeans Store Logo">
            </div>
            <h3 class="main-title">Main</h3>
            <ul class="nav flex-column">
                <!-- Chỉ hiển thị "Quản lý trạng thái đơn hàng" cho nhân viên -->
                <c:if test="${sessionScope.userRole == 'EMPLOYEE'}">
                    <li class="nav-item">
                        <a class="nav-link" href="/view-trang-thai-don-hang" target="contentFrame">
                            Quản lý trạng thái đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="/admin/logout" >Đăng xuất</a>
                    </li>
                </c:if>

                <!-- Các mục chỉ hiển thị cho ADMIN -->
                <c:if test="${sessionScope.userRole == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="/nhan-vien/hien-thi" target="contentFrame">
                            Quản lý nhân viên
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/khach-hang" target="contentFrame">
                            Quản lý khách hàng
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/api/quan-jean/quanjeans" target="contentFrame">
                            Quản lý sản phẩm
                        </a>
                    </li>

                    <!-- Quản lý thuộc tính -->
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" id="quanlyThuocTinh">
                            Quản lý thuộc tính <i class="fas fa-caret-right triangle-icon"></i>
                        </a>
                        <div class="submenu" id="thuocTinhSubmenu">
                            <a href="/api/quan-ly/chuyen-muc/chat-lieu" target="contentFrame">Chất liệu</a>
                            <a href="/api/quan-ly/chuyen-muc/ong-quan" target="contentFrame">Ống quần</a>
                            <a href="/api/quan-ly/chuyen-muc/thuong-hieu" target="contentFrame">Thương hiệu</a>
                            <a href="/api/quan-ly/list-mau-sac" target="contentFrame">Màu sắc</a>
                            <a href="/api/quan-ly/list-kich-thuoc" target="contentFrame">Kích thước</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/api/quan-ly/hoa-don/view-hoa-don" target="contentFrame">
                            Quản lý hóa đơn
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/view-trang-thai-don-hang" target="contentFrame">
                            Quản lý trạng thái đơn hàng
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="/voucher/hien-thi" target="contentFrame">Voucher</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="/thong-ke" target="contentFrame">Thống kê</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="/admin/logout" >Đăng xuất</a>
                    </li>
                </c:if>
            </ul>
        </div>
        <div class="col-md-10 main-content">
            <c:choose>
                <c:when test="${sessionScope.userRole == 'ADMIN'}">
                    <iframe name="contentFrame" src="/thong-ke" class="content-frame"></iframe>
                </c:when>

                <c:otherwise>
                    <!-- Nếu không phải ADMIN, bạn có thể hiển thị iframe khác hoặc trang mặc định -->
                    <iframe name="contentFrame" src="/view-trang-thai-don-hang" class="content-frame"></iframe>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let navLinks = document.querySelectorAll(".sidebar .nav-link");
        let quanlyThuocTinh = document.getElementById("quanlyThuocTinh");
        let thuocTinhSubmenu = document.getElementById("thuocTinhSubmenu");
        let triangleIcon = quanlyThuocTinh.querySelector(".triangle-icon");

        navLinks.forEach(function (link) {
            link.addEventListener("click", function () {
                navLinks.forEach(function (item) {
                    item.classList.remove("active");
                });
                this.classList.add("active");
            });
        });

        // Toggle submenu "Quản lý thuộc tính"
        quanlyThuocTinh.addEventListener("click", function (event) {
            event.preventDefault();
            if (thuocTinhSubmenu.style.display === "block") {
                thuocTinhSubmenu.style.display = "none";
                triangleIcon.classList.remove("fa-caret-down");
                triangleIcon.classList.add("fa-caret-right");
            } else {
                thuocTinhSubmenu.style.display = "block";
                triangleIcon.classList.remove("fa-caret-right");
                triangleIcon.classList.add("fa-caret-down");
            }
        });
    });
</script>
</body>
</html>
