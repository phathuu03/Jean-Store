<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-info">Quản Lý Khách Hàng</h2>
<br>
    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/khach-hang/search" class="d-flex">
            <input type="text" name="query" placeholder="Nhập từ khóa..."  >
            <button class="btn btn-primary ms-2" type="submit">Tìm kiếm</button>
        </form>
    </div>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>Tên Khách Hàng</th>
            <th>Tên Đăng Nhập</th>
            <th>Mật Khẩu</th>
            <th>Số Điện Thoại</th>
            <th>Địa Chỉ</th>
            <th>Email</th>
            <th>Giới Tính</th>
            <th>Ngày Tạo</th>
            <th>Ngày Sửa</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="kh" varStatus="stt">
            <tr>
                <td>${stt.index + 1}</td>
                <td>${kh.tenKhachHang}</td>
                <td>${kh.tenDangNhap}</td>
                <td>${kh.matKhau}</td>
                <td>${kh.soDienThoai}</td>
                <td>${kh.diaChi}, ${kh.phuongXa}, ${kh.quanHuyen}, ${kh.tinhTP}</td>
                <td>${kh.email}</td>
                <td>${kh.gioiTinh ? "Nam" : "Nữ"}</td>
                <td>${kh.ngayTao}</td>
                <td>${kh.ngaySua}</td>
                <td>${kh.trangThai == 1 ? "Hoạt Động" : "Ngừng Hoạt Động"}</td>
                <td>
                    <div style="display: flex; gap: 10px;">
                        <a href="/khach-hang/detail/${kh.id}" class="d-flex justify-content-center align-items-center p-2">
                            <i class="bi bi-eye-fill fs-5"></i>
                        </a>
                        <a href="/khach-hang/viewDonHang/${kh.id}" class="btn btn-secondary">Xem Đơn Hàng</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
