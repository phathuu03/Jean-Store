<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h2 class="text-info mb-4">Detail Khách Hàng</h2>

        <form>
            <div class="row g-4">
                <div class="col-md-6">
                    <label for="tenKhachHang" class="form-label">Tên Khách Hàng</label>
                    <input type="text" id="tenKhachHang" name="tenKhachHang" class="form-control" value="${kh.tenKhachHang}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="tenDangNhap" class="form-label">Tên Đăng Nhập</label>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" class="form-control" value="${kh.tenDangNhap}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="matKhau" class="form-label">Mật Khẩu</label>
                    <input type="password" id="matKhau" name="matKhau" class="form-control" value="${kh.matKhau}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="soDienThoai" class="form-label">Số Điện Thoại</label>
                    <input type="text" id="soDienThoai" name="soDienThoai" class="form-control" value="${kh.soDienThoai}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="diaChi" class="form-label">Địa Chỉ</label>
                    <input type="text" id="diaChi" name="diaChi" class="form-control" value="${kh.diaChi}, ${kh.phuongXa}, ${kh.quanHuyen}, ${kh.tinhTP}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" value="${kh.email}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="gioiTinh" class="form-label">Giới Tính</label>
                    <input type="text" id="gioiTinh" name="gioiTinh" class="form-control" value="${kh.gioiTinh ? 'Nam' : 'Nữ'}" readonly>
                </div>

                <div class="col-md-6">
                    <label for="trangThai" class="form-label">Trạng Thái</label>
                    <input type="text" id="trangThai" name="trangThai" class="form-control" value="${kh.trangThai == 1  ? 'Hoạt Động' : 'Ngừng Hoạt Động'}" readonly>
                </div>
            </div>
            <div class="mt-4">
                <a href="/khach-hang" class="btn btn-secondary">Quay Lại</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
