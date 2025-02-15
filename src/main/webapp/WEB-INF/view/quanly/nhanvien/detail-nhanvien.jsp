<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h2 class="text-info mb-4">Chi Tiết Nhân Viên</h2>

        <form>
            <div class="row g-4">
                <div class="col-md-6">
                    <label for="tenNhanVien" class="form-label">Tên Nhân Viên</label>
                    <input type="text" id="tenNhanVien" name="tenNhanVien" class="form-control" value="${nv.tenNhanVien}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="tenDangNhap" class="form-label">Tên Đăng Nhập</label>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" class="form-control" value="${nv.tenDangNhap}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="matKhau" class="form-label">Mật Khẩu</label>
                    <input type="password" id="matKhau" name="matKhau" class="form-control" value="${nv.matKhau}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="soDienThoai" class="form-label">Số Điện Thoại</label>
                    <input type="text" id="soDienThoai" name="soDienThoai" class="form-control" value="${nv.soDienThoai}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="diaChi" class="form-label">Địa Chỉ</label>
                    <input type="text" id="diaChi" name="diaChi" class="form-control" value="${nv.diaChi}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" value="${nv.email}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="gioiTinh" class="form-label">Giới Tính</label>
                    <input type="text" id="gioiTinh" name="gioiTinh" class="form-control" value="${nv.gioiTinh}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="chucVu" class="form-label">Chức Vụ</label>
                    <input type="text" id="chucVu" name="chucVu" class="form-control" value="${nv.chucVu}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="ngayTao" class="form-label">Ngày Tạo</label>
                    <input type="text" id="ngayTao" name="ngayTao" class="form-control" value="<fmt:formatDate value='${nv.ngayTao}' pattern='yyyy-MM-dd'/>" readonly>
                </div>
                <div class="col-md-6">
                    <label for="ngaySua" class="form-label">Ngày Sửa</label>
                    <input type="text" id="ngaySua" name="ngaySua" class="form-control" value="<fmt:formatDate value='${nv.ngaySua}' pattern='yyyy-MM-dd'/>" readonly>
                </div>

                <div class="col-md-6">
                    <label for="trangThai" class="form-label">Trạng Thái</label>
                    <input type="text" id="trangThai" name="trangThai" class="form-control"
                           value="${nv.trangThai == 1 ? 'Đang Làm' : 'Đã Nghỉ Làm'}" readonly>
                </div>

            </div>
            <div class="mt-4">
                <a href="/nhan-vien/hien-thi" class="btn btn-secondary">Quay Lại</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>