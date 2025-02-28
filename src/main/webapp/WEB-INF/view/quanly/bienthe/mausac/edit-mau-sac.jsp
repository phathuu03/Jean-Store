<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Màu Sắc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Chỉnh sửa Màu Sắc</h2>
    <form action="/api/quan-ly/edit-mau-sac" method="post">
        <input type="hidden" name="id" value="${mauSac.id}">
        <div class="mb-3">
            <label for="tenMauSac" class="form-label">Tên Màu Sắc:</label>
            <input type="text" class="form-control" name="tenMauSac" value="${mauSac.tenMauSac}" required>
        </div>
        <div class="mb-3">
            <label for="trangThai" class="form-label">Trạng Thái:</label>
            <select class="form-select" name="trangThai" required>
                <option value="1" ${mauSac.trangThai == 1 ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${mauSac.trangThai == 0 ? 'selected' : ''}>Không hoạt động</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Cập nhật</button>
        <a href="/api/quan-ly/list-mau-sac" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
