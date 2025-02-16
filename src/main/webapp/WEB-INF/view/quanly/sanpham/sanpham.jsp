<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Quần Jeans</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script>
        function toggleForm() {
            var form = document.getElementById("addForm");
            var toggleButton = document.getElementById("toggleButton");
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block";
                toggleButton.textContent = "Ẩn Form";
            } else {
                form.style.display = "none";
                toggleButton.textContent = "Thêm mới";
            }
        }
    </script>
</head>
<body>

<div class="container mt-4">
    <h2 class="text-info">Quản lý Quần Jeans</h2>
    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/api/quan-jean/quanjeans-search" class="d-flex">
            <input type="text" name="search" class="form-control form-control-sm" placeholder="Nhập từ khóa..." value="${param.search}">
            <button class="btn btn-primary btn-sm ms-2" type="submit">Tìm kiếm</button>
        </form>
        <button id="toggleButton" class="btn btn-success" onclick="toggleForm()">Thêm mới</button>
    </div>

    <div id="addForm" class="card shadow-lg p-4 mb-4" style="display: none;">
        <form action="${quanJeans.id == null ? '/api/quan-jean/new-quan-jean' : 'update/' + quanJeans.id}" method="post">
            <input type="hidden" name="id" value="${quanJeans.id}">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm:</label>
                        <input type="text" name="tenSanPham" value="${quanJeans.tenSanPham}" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thương hiệu:</label>
                        <select name="thuongHieu.id" class="form-select">
                            <c:forEach var="thuongHieu" items="${listThuongHieu}">
                                <option value="${thuongHieu.id}" ${quanJeans.thuongHieu.id == thuongHieu.id ? 'selected' : ''}>${thuongHieu.tenThuongHieu}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Ống quần:</label>
                        <select name="ongQuan.id" class="form-select">
                            <c:forEach var="ongQuan" items="${listOngQuan}">
                                <option value="${ongQuan.id}" ${quanJeans.ongQuan.id == ongQuan.id ? 'selected' : ''}>${ongQuan.tenOngQuan}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chất liệu:</label>
                        <select name="chatLieu.id" class="form-select">
                            <c:forEach var="chatLieu" items="${listChatLieu}">
                                <option value="${chatLieu.id}" ${quanJeans.chatLieu.id == chatLieu.id ? 'selected' : ''}>${chatLieu.tenChatLieu}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </div>

    <table class="table table-bordered table-striped">
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
                <td>${quanJeans.trangThai == 0 ? "Còn hàng" : quanJeans.trangThai == 1 ? "Hết hàng" : "Sắp về hàng"}</td>
                <td>${quanJeans.thuongHieu.tenThuongHieu}</td>
                <td>${quanJeans.chatLieu.tenChatLieu}</td>
                <td>${quanJeans.ongQuan.tenOngQuan}</td>
                <td>
                    <div class="d-flex gap-2">
                        <a href="detail/${quanJeans.id}" class="d-flex justify-content-center align-items-center p-2">
                            <i class="bi bi-eye-fill fs-5"></i>
                        </a>
                        <a href="edit/${quanJeans.id}" class="btn btn-primary btn-sm">Chỉnh sửa</a>
                        <a href="delete/${quanJeans.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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
