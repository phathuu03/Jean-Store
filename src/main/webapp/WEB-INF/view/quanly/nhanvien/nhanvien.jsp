<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Nhân Viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>
<body>
<div class="container mt-4">
    <h2 class="text-info">Quản Lý Nhân Viên</h2>

<%--    <form action="" method="">--%>
<%--        <div class="row">--%>
<%--            <div class="col-md-6">--%>
<%--                <div class="mb-3">--%>
<%--                    <label for="tenNhanVien" class="form-label">Tên Nhân Viên:</label>--%>
<%--                    <input type="text" id="tenNhanVien" name="tenNhanVien" class="form-control" placeholder="Nhập tên nhân viên">--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="col-md-6">--%>
<%--                <div class="mb-3">--%>
<%--                    <label for="tenDangNhap" class="form-label">Tên Đăng Nhập:</label>--%>
<%--                    <input type="text" id="tenDangNhap" name="tenDangNhap" class="form-control" placeholder="Nhập tên đăng nhập">--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="col-md-6">--%>
<%--                <div class="mb-3">--%>
<%--                    <label for="matKhau" class="form-label">Mật Khẩu:</label>--%>
<%--                    <input type="password" id="matKhau" name="matKhau" class="form-control" placeholder="Nhập mật khẩu">--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="col-md-6">--%>
<%--                <div class="mb-3">--%>
<%--                    <label for="soDienThoai" class="form-label">Số Điện Thoại:</label>--%>
<%--                    <input type="text" id="soDienThoai" name="soDienThoai" class="form-control" placeholder="Nhập số điện thoại">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </form>--%>

    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/search" class="d-flex">
            <input type="text" name="query" placeholder="Nhập từ khóa...">
            <button class="btn btn-primary ms-2" type="submit">Tìm kiếm</button>
        </form>

    <a href="/nhan-vien/view-add" class="btn btn-success">+ Thêm Mới</a>
</div>


    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>Tên Nhân Viên</th>
            <th>Tên Đăng Nhập</th>
            <th>Mật Khẩu</th>
            <th>Số Điện Thoại</th>
            <th>Địa Chỉ</th>
            <th>Email</th>
            <th>Giới Tính</th>
            <th>Chức Vụ</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="nv" varStatus="stt">
            <tr>
                <td>${stt.index + 1}</td>
                <td>${nv.tenNhanVien}</td>
                <td>${nv.tenDangNhap}</td>
                <td>${nv.matKhau}</td>
                <td>${nv.soDienThoai}</td>
                <td>${nv.diaChi}</td>
                <td>${nv.email}</td>
                <td>${nv.gioiTinh == true ? "Nam" : "Nữ"}</td>
                <td>${nv.chucVu}</td>
                <td>${nv.trangThai ==  1 ? "Đang Làm" : "Đã Nghỉ Làm"}</td>
                    <td>
                        <div style="display: flex; gap: 10px;">
                            <a href="/nhan-vien/detail/${nv.id}" class="d-flex justify-content-center align-items-center p-2">
                                <i class="bi bi-eye-fill fs-5"></i>
                            </a>
                            <a href="/nhan-vien/view-update/${nv.id}" class="btn btn-secondary">Update</a>
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
