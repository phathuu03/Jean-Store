<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết Hóa Đơn Chi Tiết</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Chi tiết Hóa Đơn Chi Tiết</h2>

    <div class="card shadow-lg p-4">
        <div class="row">
            <!-- Cột trái: Thông tin Hóa Đơn Chi Tiết -->
            <div class="col-md-6">
                <h4 class="text-primary">Thông tin Hóa Đơn Chi Tiết</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>ID:</strong> ${hoaDonChiTiet.id}</li>
                    <li class="list-group-item"><strong>Số lượng:</strong> ${hoaDonChiTiet.soLuong}</li>
                    <li class="list-group-item"><strong>Đơn giá:</strong> ${hoaDonChiTiet.donGia}</li>
                    <li class="list-group-item"><strong>Tổng tiền:</strong> ${hoaDonChiTiet.tongTien}</li>
                    <li class="list-group-item"><strong>Ngày Thanh Toán:</strong>
                        <c:if test="${hoaDonChiTiet.ngayThanhToan != null}">
                            <fmt:formatDate value="${hoaDonChiTiet.ngayThanhToan}" pattern="dd/MM/yyyy" />
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Ngày Tạo:</strong>
                        <fmt:formatDate value="${hoaDonChiTiet.ngayTao}" pattern="dd/MM/yyyy" />
                    </li>
                    <li class="list-group-item"><strong>Ngày Sửa:</strong>
                        <fmt:formatDate value="${hoaDonChiTiet.ngaySua}" pattern="dd/MM/yyyy" />
                    </li>

                </ul>
            </div>

            <!-- Cột phải: Thông tin bổ sung -->
            <div class="col-md-6">
                <h4 class="text-success">Thông tin bổ sung</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Hóa Đơn:</strong>
                        <c:if test="${hoaDonChiTiet.hoaDon != null}">
                            Hóa đơn #${hoaDonChiTiet.hoaDon.id}
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Sản phẩm:</strong>
                        <c:if test="${hoaDonChiTiet.quanJeansChiTiet != null}">
                            ${hoaDonChiTiet.quanJeansChiTiet.quanJeans.tenSanPham}
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Phương Thức Thanh Toán:</strong>
                        <c:if test="${hoaDonChiTiet.pttt != null}">
                            ${hoaDonChiTiet.pttt.tenPTTT}
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Trạng Thái:</strong>
                        ${hoaDonChiTiet.trangThai == 0 ? "Chưa Thanh Toán" : "Đã Thanh Toán"}
                    </li>
                </ul>
            </div>
        </div>

        <!-- Nút điều hướng -->
        <div class="mt-4 text-center">
            <a href="/api/quan-ly/hoa-don/view/san-pham-chi-tiet/${hoaDonChiTiet.id}" class="btn btn-primary">Xem chi tiết sản phẩm</a>
            <a href="javascript:window.history.back()" class="btn btn-secondary me-2">Quay lại danh sách</a>
        </div>
    </div>


</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
