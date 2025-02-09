<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Quần Jeans</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center mb-4">Quản lý Quần Jeans</h2>

    <!-- Nút thêm mới -->
    <div class="mb-3">
        <a href="new" class="btn btn-success">Thêm mới</a>
    </div>

    <!-- Form nhập liệu -->
    <div class="card p-4 mb-4">
        <form action="${quanJeans.id == null ? '/api/quan-jean/new-quan-jean' : 'update/' + quanJeans.id}" method="post">
            <input type="hidden" name="id" value="${quanJeans.id}">

            <div class="mb-3">
                <label class="form-label">Tên sản phẩm:</label>
                <input type="text" name="tenSanPham" value="${quanJeans.tenSanPham}" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Thương hiệu:</label>
                <select name="thuongHieu.id" class="form-select">
                    <c:forEach var="thuongHieu" items="${listThuongHieu}">
                        <option value="${thuongHieu.id}" ${quanJeans.thuongHieu.id == thuongHieu.id ? 'selected' : ''}>
                                ${thuongHieu.tenThuongHieu}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Ống quần:</label>
                <select name="ongQuan.id" class="form-select">
                    <c:forEach var="ongQuan" items="${listOngQuan}">
                        <option value="${ongQuan.id}" ${quanJeans.ongQuan.id == ongQuan.id ? 'selected' : ''}>
                                ${ongQuan.tenOngQuan}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Chất liệu:</label>
                <select name="chatLieu.id" class="form-select">
                    <c:forEach var="chatLieu" items="${listChatLieu}">
                        <option value="${chatLieu.id}" ${quanJeans.chatLieu.id == chatLieu.id ? 'selected' : ''}>
                                ${chatLieu.tenChatLieu}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Trạng thái:</label>
                <input type="number" name="trangThai" value="${quanJeans.trangThai}" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary">Lưu</button>
        </form>
    </div>

    <!-- Bảng danh sách sản phẩm -->
    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Sản Phẩm</th>
            <th>Ngày Tạo</th>
            <th>Ngày Sửa</th>
            <th>Trạng Thái</th>
            <th>Thương hiệu</th>
            <th>Chất Liệu</th>
            <th>Ống Quần</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="quanJeans" items="${listQuanJean}">
            <tr>
                <td>${quanJeans.id}</td>
                <td>${quanJeans.tenSanPham}</td>
                <td>${quanJeans.ngayTao}</td>
                <td>${quanJeans.ngaySua}</td>
                <td>${quanJeans.trangThai}</td>
                <td>${quanJeans.thuongHieu.tenThuongHieu}</td>
                <td>${quanJeans.chatLieu.tenChatLieu}</td>
                <td>${quanJeans.ongQuan.tenOngQuan}</td>
                <td>
                    <a href="edit/${quanJeans.id}" class="btn btn-warning btn-sm">Chi tiết</a>
                    <a href="delete/${quanJeans.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
