<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thương Hiệu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-4">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">Quản lý Thương Hiệu</h3>
        </div>
        <div class="card-body">
            <form action="/api/quan-ly/new-thuong-hieu" method="post" class="mb-4 row g-3 align-items-center">
                <div class="col-md-8">
                    <input type="text" class="form-control" name="tenThuongHieu" placeholder="Nhập tên thương hiệu" required>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="trangThai" required>
                        <option value="1">Hoạt động</option>
                        <option value="0">Không hoạt động</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-success w-100">Thêm</button>
                </div>
            </form>
            <div class="table-responsive">
                <table class="table table-hover table-striped table-bordered">
                    <thead class="table-dark">
                    <tr>
                        <th>Tên Thương Hiệu</th>
                        <th>Trạng Thái</th>
                        <th>Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="thuongHieu" items="${listThuongHieu}">
                        <tr>
                            <td>${thuongHieu.tenThuongHieu}</td>
                            <td>
                                    <span class="badge ${thuongHieu.trangThai == 1 ? 'bg-success' : 'bg-danger'}">
                                            ${thuongHieu.trangThai == 1 ? 'Hoạt động' : 'Không hoạt động'}
                                    </span>
                            </td>
                            <td>
                                <a href="/api/quan-ly/edit-thuong-hieu/${thuongHieu.id}" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="/api/quan-ly/delete-thuong-hieu/${thuongHieu.id}" class="btn btn-danger btn-sm">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
