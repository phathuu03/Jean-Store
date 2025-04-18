<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Chất Liệu, Loại Ống Quần, và Thương Hiệu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 20px;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Quản lý Chất Liệu, Loại Ống Quần, và Thương Hiệu</h2>

    <!-- Quản lý Chất Liệu -->
    <div class="row">
        <div class="col-md-12">
            <h3 class="mb-3">Quản lý Chất Liệu</h3>
            <form action="/api/quan-ly/new-chat-lieu" method="post" class="mb-4 row g-3">
                <div class="col-md-8">
                    <input type="text" class="form-control" name="tenChatLieu" placeholder="Nhập tên chất liệu" required>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="trangThai" required>
                        <option value="1">Hoạt động</option>
                        <option value="0">Không hoạt động</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary w-100">Thêm</button>
                </div>
            </form>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                <tr>
                    <th>Tên Chất Liệu</th>
                    <th>Trạng Thái</th>
                    <th>Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="chatLieu" items="${listChatLieu}">
                    <tr>
                        <td>${chatLieu.tenChatLieu}</td>
                        <td>${chatLieu.trangThai == 1 ? 'Hoạt động' : 'Không hoạt động'}</td>
                        <td>
                            <a href="/api/quan-ly/edit-chat-lieu/${chatLieu.id}" class="btn btn-warning">Sửa</a>
                            <a href="/api/quan-ly/delete-chat-lieu/${chatLieu.id}" class="btn btn-danger">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <hr>

    <!-- Quản lý Loại Ống Quần -->
    <div class="row">
        <div class="col-md-12">
            <h3 class="mb-3">Quản lý Loại Ống Quần</h3>
            <form action="/api/quan-ly/new-ong-quan" method="post" class="mb-4 row g-3">
                <div class="col-md-8">
                    <input type="text" class="form-control" name="tenOngQuan" placeholder="Nhập tên loại ống quần" required>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="trangThai" required>
                        <option value="1">Hoạt động</option>
                        <option value="0">Không hoạt động</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary w-100">Thêm</button>
                </div>
            </form>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                <tr>
                    <th>Tên Loại Ống Quần</th>
                    <th>Trạng Thái</th>
                    <th>Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ongQuan" items="${listOngQuan}">
                    <tr>
                        <td>${ongQuan.tenOngQuan}</td>
                        <td>${ongQuan.trangThai == 1 ? 'Hoạt động' : 'Không hoạt động'}</td>
                        <td>
                            <a href="/api/quan-ly/edit-ong-quan/${ongQuan.id}" class="btn btn-warning">Sửa</a>
                            <a href="/api/quan-ly/delete-ong-quan/${ongQuan.id}" class="btn btn-danger">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <hr>

    <!-- Quản lý Thương Hiệu -->
    <div class="row">
        <div class="col-md-12">
            <h3 class="mb-3">Quản lý Thương Hiệu</h3>
            <form action="/api/quan-ly/new-thuong-hieu" method="post" class="mb-4 row g-3">
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
                    <button type="submit" class="btn btn-primary w-100">Thêm</button>
                </div>
            </form>
            <table class="table table-bordered table-striped">
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
                        <td>${thuongHieu.trangThai == 1 ? 'Hoạt động' : 'Không hoạt động'}</td>
                        <td>
                            <a href="/api/quan-ly/edit-thuong-hieu/${thuongHieu.id}" class="btn btn-warning">Sửa</a>
                            <a href="/api/quan-ly/delete-thuong-hieu/${thuongHieu.id}" class="btn btn-danger">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
