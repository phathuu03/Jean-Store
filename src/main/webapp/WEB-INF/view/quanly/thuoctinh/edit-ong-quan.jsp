<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Ống Quần</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Chỉnh sửa Ống Quần</h2>

    <!-- Hiển thị lỗi nếu có -->
    <div class="mt-4 text-center">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
    </div>

    <form action="/api/quan-ly/update-ong-quan" method="post">
        <input type="hidden" name="id" value="${ongQuan.id}">

        <div class="mb-3">
            <label for="tenOngQuan" class="form-label">Tên Ống Quần:</label>
            <input type="text" class="form-control" name="tenOngQuan" value="${ongQuan.tenOngQuan}" required>
        </div>

        <div class="mb-3">
            <label for="trangThai" class="form-label">Trạng Thái:</label>
            <select class="form-select" name="trangThai" required>
                <option value="1" ${ongQuan.trangThai == 1 ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${ongQuan.trangThai == 0 ? 'selected' : ''}>Không hoạt động</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Cập nhật</button>
        <a href="http://localhost:8080/api/quan-ly/chuyen-muc/ong-quan" class="btn btn-secondary">Quay lại</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
