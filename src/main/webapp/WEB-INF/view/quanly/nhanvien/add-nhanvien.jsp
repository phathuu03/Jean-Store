<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Nhân Viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h2 class="text-info ">Thêm Nhân Viên</h2>
        <form action="/nhan-vien/add" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="tenNhanVien" class="form-label">Tên Nhân Viên</label>
                    <input type="text" id="tenNhanVien" name="tenNhanVien" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="tenDangNhap" class="form-label">Tên Đăng Nhập</label>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" class="form-control" required>

                    <!-- Hiển thị lỗi nếu tên đăng nhập đã tồn tại -->
                    <c:if test="${not empty tenDangNhapError}">
                        <div class="text-danger mt-2">${tenDangNhapError}</div>
                    </c:if>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="matKhau" class="form-label">Mật Khẩu</label>
                    <input type="password" id="matKhau" name="matKhau" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="soDienThoai" class="form-label">Số Điện Thoại</label>
                    <input type="tel" id="soDienThoai" name="soDienThoai" class="form-control" pattern="[0-9]{10,11}" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="diaChi" class="form-label">Địa Chỉ</label>
                    <input type="text" id="diaChi" name="diaChi" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Giới Tính</label>
                    <div>
                        <input type="radio" id="nam" name="gioiTinh" value="true" checked>
                        <label for="nam">Nam</label>

                        <input type="radio" id="nu" name="gioiTinh" value="false">
                        <label for="nu">Nữ</label>
                    </div>

                </div>
                <div class="col-md-6 mb-3">
                    <label for="chucVu" class="form-label">Chức Vụ</label>
                    <select id="chucVu" name="chucVu" class="form-select" required>
                        <option value="Nhân Viên">Nhân Viên</option>
                        <option value="Quản Lý">Quản Lý</option>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="trangThai" class="form-label">Trạng Thái</label>
                    <select id="trangThai" name="trangThai" class="form-select" required>
                        <option value="1">Đang Làm</option>
                        <option value="0">Đã Nghỉ Làm</option>
                    </select>

                </div>
            </div>

            <div class="">
                <button type="submit" class="btn btn-success">Thêm Mới</button>
                <a href="/nhan-vien/hien-thi" class="btn btn-secondary">Quay Lại</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
