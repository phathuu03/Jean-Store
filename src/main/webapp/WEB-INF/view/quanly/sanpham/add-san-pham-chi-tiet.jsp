<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <h2 class="text-info text-center">Thêm Chi Tiết Sản Phẩm</h2>

    <div class="card shadow-lg p-4">
        <form action="/quan-jean-chi-tiet/save" method="post">
            <!-- ID sản phẩm -->
            <input type="hidden" name="quanJeans.id" value="${quanJeans.id}">

            <!-- Hiển thị thông tin sản phẩm -->
            <h4 class="text-primary">Thông Tin Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-3">
                    <label class="fw-bold">Tên sản phẩm:</label>
                    <p class="form-control-plaintext">${quanJeans.tenSanPham}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Thương hiệu:</label>
                    <p class="form-control-plaintext">${quanJeans.thuongHieu.tenThuongHieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Chất liệu:</label>
                    <p class="form-control-plaintext">${quanJeans.chatLieu.tenChatLieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Ống quần:</label>
                    <p class="form-control-plaintext">${quanJeans.ongQuan.tenOngQuan}</p>
                </div>
            </div>

            <!-- Nhập thông tin chi tiết sản phẩm -->
            <h4 class="text-primary">Chi Tiết Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Mô tả:</label>
                    <textarea name="moTa" class="form-control" rows="3" required></textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="number" name="gia" class="form-control" step="0.01" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Màu sắc:</label>
                    <select name="mauSac.id" class="form-select" required>
                        <c:forEach var="mauSac" items="${listMauSac}">
                            <option value="${mauSac.id}">${mauSac.tenMauSac}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Kích thước:</label>
                    <select name="size.id" class="form-select" required>
                        <c:forEach var="size" items="${listSize}">
                            <option value="${size.id}">${size.tenSize}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Số lượng:</label>
                    <input type="number" name="soLuong" class="form-control" min="1" required>
                </div>
            </div>

            <!-- Trạng thái -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Trạng thái:</label>
                    <div class="d-flex gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="trangThai" value="0" checked>
                            <label class="form-check-label">Còn hàng</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="trangThai" value="1">
                            <label class="form-check-label">Hết hàng</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Nút Lưu -->
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Lưu Chi Tiết</button>
                <a href="/quan-jean-chi-tiet" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
