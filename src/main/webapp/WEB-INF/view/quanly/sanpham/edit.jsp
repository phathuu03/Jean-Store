<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết Quần Jeans</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Chi tiết Quần Jeans</h2>

    <div class="card shadow-lg p-4">
        <div class="row">
            <div class="col-md-6">
                <h4 class="text-primary">Thông tin sản phẩm</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>ID:</strong> ${quanJeans.id}</li>
                    <li class="list-group-item"><strong>Tên sản phẩm:</strong> ${quanJeans.tenSanPham}</li>
                    <li class="list-group-item"><strong>Ngày tạo:</strong> ${quanJeans.ngayTao}</li>
                    <li class="list-group-item"><strong>Ngày sửa:</strong> ${quanJeans.ngaySua}</li>
                    <li class="list-group-item"><strong>Trạng thái:</strong> ${quanJeans.trangThai}</li>
                </ul>
            </div>

            <div class="col-md-6">
                <h4 class="text-success">Thông tin bổ sung</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Thương hiệu:</strong> ${quanJeans.thuongHieu.tenThuongHieu}</li>
                    <li class="list-group-item"><strong>Chất liệu:</strong> ${quanJeans.chatLieu.tenChatLieu}</li>
                    <li class="list-group-item"><strong>Ống quần:</strong> ${quanJeans.ongQuan.tenOngQuan}</li>
                </ul>
            </div>
        </div>

        <!-- Nút điều hướng -->
        <div class="mt-4 text-center">
            <a href="edit/${quanJeans.id}" class="btn btn-warning me-2">Chỉnh sửa</a>
            <a href="/api/quan-jean/delete/${quanJeans.id}" class="btn btn-danger me-2" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
            <a href="/api/quan-jean/quanjeans" class="btn btn-secondary">Quay lại danh sách</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
