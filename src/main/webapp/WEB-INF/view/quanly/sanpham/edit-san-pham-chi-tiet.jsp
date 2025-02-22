<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh Sửa Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <h2 class="text-info text-center">Chỉnh Sửa Chi Tiết Sản Phẩm</h2>

    <div class="card shadow-lg p-4">
        <form action="${pageContext.request.contextPath}/api/quan-jeans-chi-tiet/update/${quanJeansChiTiet.id}" method="post">
            <!-- Ẩn ID sản phẩm gốc -->
            <input type="hidden" name="quanJeans.id" value="${quanJeansChiTiet.quanJeans.id}">

            <!-- Hiển thị thông tin sản phẩm (read-only) -->
            <h4 class="text-primary">Thông Tin Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-3">
                    <label class="fw-bold">Tên sản phẩm:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.tenSanPham}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Thương hiệu:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.thuongHieu.tenThuongHieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Chất liệu:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.chatLieu.tenChatLieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Ống quần:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.ongQuan.tenOngQuan}</p>
                </div>
            </div>

            <!-- Thông tin chi tiết sản phẩm -->
            <h4 class="text-primary">Chi Tiết Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Mô tả:</label>
                    <textarea name="moTa" class="form-control" rows="3" required>${quanJeansChiTiet.moTa}</textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Giá (VND):</label>
                    <input type="number" name="gia" class="form-control" step="0.01" value="${quanJeansChiTiet.gia}" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Màu sắc:</label>
                    <select name="mauSac.id" class="form-select" required>
                        <c:forEach var="mauSac" items="${listMauSac}">
                            <option value="${mauSac.id}" <c:if test="${mauSac.id == quanJeansChiTiet.mauSac.id}">selected</c:if>>
                                    ${mauSac.tenMauSac}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Kích thước:</label>
                    <select name="size.id" class="form-select" required>
                        <c:forEach var="size" items="${listSize}">
                            <option value="${size.id}" <c:if test="${size.id == quanJeansChiTiet.size.id}">selected</c:if>>
                                    ${size.tenSize}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Số lượng:</label>
                    <input type="number" name="soLuong" class="form-control" min="1" value="${quanJeansChiTiet.soLuong}" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Trạng thái:</label>
                    <div class="d-flex gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="trangThai" value="0" <c:if test="${quanJeansChiTiet.trangThai == 0}">checked</c:if>>
                            <label class="form-check-label">Còn hàng</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="trangThai" value="1" <c:if test="${quanJeansChiTiet.trangThai == 1}">checked</c:if>>
                            <label class="form-check-label">Hết hàng</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Nút điều hướng -->
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Cập Nhật Chi Tiết</button>
                <a href="${pageContext.request.contextPath}/api/quan-jean/detail/${quanJeansChiTiet.quanJeans.id}" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
