<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Quần Jeans</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <h2 class="text-center mb-4">Quản lý Quần Jeans</h2>

    <!-- Nút thêm mới -->
    <div class="mb-3">
        <button id="toggleButton" class="btn btn-success" onclick="toggleForm()">Thêm mới</button>
    </div>

    <!-- Form nhập liệu - Chia làm 2 cột, Ẩn mặc định -->
    <div id="addForm" class="card shadow-lg p-4 mb-4" style="display: none;">
        <form action="${quanJeans.id == null ? '/api/quan-jean/new-quan-jean' : 'update/' + quanJeans.id}" method="post">
            <input type="hidden" name="id" value="${quanJeans.id}">

            <div class="row">
                <!-- Cột bên trái -->
                <div class="col-md-6">
                    <h4 class="text-primary">Thông tin sản phẩm</h4>
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
                        <label class="form-label">Trạng thái:</label>
                        <div class="d-flex gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="trangThai" value="0" ${quanJeans.trangThai == 0 ? 'checked' : ''}>
                                <label class="form-check-label">Còn hàng</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="trangThai" value="1" ${quanJeans.trangThai == 1 ? 'checked' : ''}>
                                <label class="form-check-label">Hết hàng</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="trangThai" value="2" ${quanJeans.trangThai == 2 ? 'checked' : ''}>
                                <label class="form-check-label">Sắp về hàng</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột bên phải -->
                <div class="col-md-6">
                    <h4 class="text-success">Thông tin bổ sung</h4>
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
                </div>
            </div>

            <!-- Nút lưu -->
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </div>
</div>
<!-- Form tìm kiếm -->
<form action="/api/quan-jean/quanjeans-search" method="get">
    <input type="text" name="search" placeholder="Tìm kiếm sản phẩm..." value="${param.search}">
    <button type="submit">Tìm kiếm</button>
</form>
<!-- Bảng danh sách sản phẩm -->
<table class="table table-striped table-hover mt-4">
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
            <td>
                <c:choose>
                    <c:when test="${quanJeans.trangThai == 0}">Còn hàng</c:when>
                    <c:when test="${quanJeans.trangThai == 1}">Hết hàng</c:when>
                    <c:when test="${quanJeans.trangThai == 2}">Sắp về hàng</c:when>
                    <c:otherwise>Không xác định</c:otherwise>
                </c:choose>
            </td>
            <td>${quanJeans.thuongHieu.tenThuongHieu}</td>
            <td>${quanJeans.chatLieu.tenChatLieu}</td>
            <td>${quanJeans.ongQuan.tenOngQuan}</td>
            <td>
                <a href="detail/${quanJeans.id}" class="btn btn-warning btn-sm">Chi tiết</a>
                <a href="edit/${quanJeans.id}" class="btn btn-primary btn-sm">Chỉnh sửa</a>
                <a href="delete/${quanJeans.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
