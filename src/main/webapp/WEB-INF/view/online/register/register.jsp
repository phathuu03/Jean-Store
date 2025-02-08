<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style>
        .margin-top{
            margin-top: 100px;
        }

    </style>
    <meta charset="UTF-8">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<header class="p-3 bg-dark text-white mb-5 fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/#">Jeans Store</a>
        </div>
    </nav>
</header>

<div class="container  mb-3 pt-5 margin-top">
    <h2 class="text-center">Đăng Ký</h2>
    <div class="card mt-4">
        <div class="card-body">
            <form>
                <!-- Các trường nhập liệu của bạn ở đây -->
                <div class="mb-3">
                    <label for="TENKHACHHANG" class="form-label">Tên Khách Hàng</label>
                    <input type="text" class="form-control" id="TENKHACHHANG" required>
                </div>
                <div class="mb-3">
                    <label for="TENDANGNHAP" class="form-label">Tên Đăng Nhập</label>
                    <input type="text" class="form-control" id="TENDANGNHAP" required>
                </div>
                <div class="mb-3">
                    <label for="MATKHAU" class="form-label">Mật Khẩu</label>
                    <input type="password" class="form-control" id="MATKHAU" required>
                </div>
                <div class="mb-3">
                    <label for="SODIENTHOAI" class="form-label">Số Điện Thoại</label>
                    <input type="tel" class="form-control" id="SODIENTHOAI" required>
                </div>
                <div class="mb-3">
                    <label for="DIACHI" class="form-label">Địa Chỉ</label>
                    <input type="text" class="form-control" id="DIACHI" required>
                </div>
                <div class="mb-3">
                    <label for="EMAIL" class="form-label">Email</label>
                    <input type="email" class="form-control" id="EMAIL" required>
                </div>
                <div class="mb-3">
                    <label for="GIOITINH" class="form-label">Giới Tính</label>
                    <select class="form-select" id="GIOITINH" required>
                        <option value="">Chọn...</option>
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>
                <div class="d-md-flex justify-content-md-center align-items-center mb-3 mt-3">
                    <button type="submit" class="btn btn-primary mt-3">Đăng Ký</button>
                </div>

                <div class="d-flex justify-content-center">
                    <span>Đã có tài khoản? <a href="#">Đăng nhập</a></span>
                </div>
            </form>
        </div>
    </div>
    <div class="container">
        <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
            <div class="col-md-4 d-flex align-items-center">
                <a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                    <svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
                </a>
                <span class="text-muted">© 2025 Company, Jeans Store</span>
            </div>

            <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">

            </ul>
        </footer>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
