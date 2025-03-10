<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h2 class="text-info mb-4">Update Khách Hàng</h2>

        <form action="/khach-hang/update/${kh.id}" method="post">
            <div class="row g-4">
                <div class="col-md-6">
                    <label for="tenKhachHang" class="form-label">Tên Khách Hàng</label>
                    <input type="text" id="tenKhachHang" name="tenKhachHang" class="form-control" value="${kh.tenKhachHang}" required>
                </div>
                <div class="col-md-6">
                    <label for="tenDangNhap" class="form-label">Tên Đăng Nhập</label>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" class="form-control" value="${kh.tenDangNhap}" required>
                </div>
                <div class="col-md-6">
                    <label for="matKhau" class="form-label">Mật Khẩu</label>
                    <input type="password" id="matKhau" name="matKhau" class="form-control" value="${kh.matKhau}" required>
                </div>
                <div class="col-md-6">
                    <label for="soDienThoai" class="form-label">Số Điện Thoại</label>
                    <input type="text" id="soDienThoai" name="soDienThoai" class="form-control" value="${kh.soDienThoai}" required>
                </div>
                <div class="col-md-6">
                    <label for="diaChi" class="form-label">Địa Chỉ</label>
                    <input type="text" id="diaChi" name="diaChi" class="form-control" value="${kh.diaChi}" required>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" value="${kh.email}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Giới Tính</label>
                    <div>
                        <input type="radio" id="nam" name="gioiTinh" value="true" ${kh.gioiTinh ? 'checked' : ''}>
                        <label for="nam">Nam</label>
                        <input type="radio" id="nu" name="gioiTinh" value="false" ${!kh.gioiTinh ? 'checked' : ''}>
                        <label for="nu">Nữ</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label for="trangThai" class="form-label">Trạng Thái</label>
                    <select id="trangThai" name="trangThai" class="form-select" required>
                        <option value="0" th:selected="${kh.trangThai == 0}">Hoạt Động</option>
                        <option value="1" th:selected="${kh.trangThai == 1}">Ngừng Hoạt Động</option>
                    </select>
                </div>


            </div>
            <div class="mt-4">
                <button type="submit" class="btn btn-success">Update</button>
                <a href="/khach-hang" class="btn btn-secondary">Quay Lại</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
