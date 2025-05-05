<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chỉnh Sửa Thương Hiệu</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">Chỉnh Sửa Thương Hiệu</h2>

    <!-- Hiển thị lỗi nếu có -->
    <div class="mt-4 text-center">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
    </div>

    <form action="/api/quan-ly/update-thuong-hieu" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="${thuongHieu.id}" />

        <div class="mb-3">
            <label for="tenThuongHieu" class="form-label">Tên Thương Hiệu:</label>
            <input type="text" id="tenThuongHieu" name="tenThuongHieu" class="form-control" value="${thuongHieu.tenThuongHieu}" required />
        </div>

        <div class="mb-3">
            <label for="trangThai" class="form-label">Trạng Thái:</label>
            <select id="trangThai" name="trangThai" class="form-select">
                <option value="1" ${thuongHieu.trangThai == 1 ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${thuongHieu.trangThai == 0 ? 'selected' : ''}>Không hoạt động</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="http://localhost:8080/api/quan-ly/chuyen-muc/thuong-hieu" class="btn btn-secondary">Quay lại</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
