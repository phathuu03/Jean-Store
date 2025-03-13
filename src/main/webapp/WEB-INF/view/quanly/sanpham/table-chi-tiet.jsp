<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh Sách Chi Tiết Sản Phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        /* Màu nền nhẹ cho toàn bộ trang */
        body {
            background-color: #f8f9fa;
        }
        /* Tạo bảng trắng với đổ bóng và border-radius */
        .table {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }
        /* Sửa màu tiêu đề bảng */
        thead.table-dark {
            background-color: #343a40;
        }
        /* Tùy chỉnh button: màu nền khi hover được thay đổi sang màu nền đậm hơn */
        .btn-outline-secondary {
            color: #6c757d;
            border-color: #6c757d;
        }
        .btn-outline-secondary:hover {
            background-color: #6c757d;
            color: #fff;
        }
        .btn-outline-info {
            color: #17a2b8;
            border-color: #17a2b8;
        }
        .btn-outline-info:hover {
            background-color: #17a2b8;
            color: #fff;
        }
        .btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        .btn-outline-danger:hover {
            background-color: #dc3545;
            color: #fff;
        }
        /* Khoảng cách giữa các nút hành động */
        .action-btns {
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="container my-4">
    <h2 class="text-center text-muted mb-4">Danh Sách Chi Tiết Sản Phẩm</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Màu Sắc</th>
                <th>Size</th>
                <th>Giá</th>
                <th>Số Lượng</th>
                <th>Trạng Thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="chiTiet" items="${listQuanJeansChiTiet}">
                <c:if test="${empty param.filter || chiTiet.trangThai == param.filter}">
                    <tr>
                        <td>${chiTiet.id}</td>
                        <td>${chiTiet.mauSac.tenMauSac}</td>
                        <td>${chiTiet.size.tenSize}</td>
                        <td>${chiTiet.gia} VND</td>
                        <td>${chiTiet.soLuong}</td>
                        <td>${chiTiet.trangThai == 0 ? "Không hoạt động" : "Hoạt động"}</td>
                        <td>
                            <div class="d-flex action-btns justify-content-evenly">
                                <a href="/api/quan-jeans-chi-tiet/edit/${chiTiet.id}"
                                   class="btn btn-outline-secondary btn-sm py-2 px-3">
                                    <i class="bi bi-pencil"></i> Sửa
                                </a>
                                <a href="/api/quan-ly/hoa-don/view/san-pham-chi-tiet/${chiTiet.id}"
                                   class="btn btn-outline-info btn-sm py-2 px-3">
                                    <i class="bi bi-eye"></i> Xem
                                </a>
                                <a href="/api/quan-jeans-chi-tiet/delete/${chiTiet.id}"
                                   class="btn btn-outline-danger btn-sm py-2 px-3">
                                    <i class="bi bi-exclamation-triangle"></i> Trạng thái
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- Bootstrap JS Bundle (bao gồm Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
