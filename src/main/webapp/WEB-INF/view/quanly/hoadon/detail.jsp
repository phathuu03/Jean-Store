<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết Hóa Đơn</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Chi tiết Hóa Đơn</h2>

    <div class="card shadow-lg p-4">
        <div class="row">
            <!-- Cột trái: Thông tin Hóa Đơn -->
            <div class="col-md-6">
                <h4 class="text-primary">Thông tin Hóa Đơn</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>ID:</strong> ${hoaDon.id}</li>
                    <li class="list-group-item"><strong>Tổng Tiền:</strong> ${hoaDon.tongTien}</li>
                    <li class="list-group-item"><strong>Địa Chỉ Giao Hàng:</strong> ${hoaDon.diaChiGiaoHang}</li>
                    <li class="list-group-item"><strong>Ngày Thanh Toán:</strong>
                        <c:if test="${hoaDon.ngayThanhToan != null}">
                            <fmt:formatDate value="${hoaDon.ngayThanhToan}" pattern="dd/MM/yyyy" />
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Ngày Tạo:</strong>
                        <fmt:formatDate value="${hoaDon.ngayTao}" pattern="dd/MM/yyyy" />
                    </li>
                    <li class="list-group-item"><strong>Ngày Sửa:</strong>
                        <fmt:formatDate value="${hoaDon.ngaySua}" pattern="dd/MM/yyyy" />
                    </li>
                    <li class="list-group-item"><strong>Trạng Thái:</strong> ${hoaDon.trangThai}</li>
                </ul>
            </div>

            <!-- Cột phải: Thông tin bổ sung -->
            <div class="col-md-6">
                <h4 class="text-success">Thông tin bổ sung</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Khách Hàng:</strong>
                        <c:if test="${hoaDon.khachHang != null}">
                            ${hoaDon.khachHang.tenKhachHang}
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Nhân Viên:</strong>
                        <c:if test="${hoaDon.nhanVien != null}">
                            ${hoaDon.nhanVien.tenNhanVien}
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Voucher:</strong>
                        <c:if test="${hoaDon.voucher != null}">
                            ${hoaDon.voucher.tenVoucher}
                        </c:if>
                    </li>
                    <li class="list-group-item"><strong>Phương Thức Thanh Toán:</strong>
                        <c:if test="${hoaDon.pttt != null}">
                            ${hoaDon.pttt.tenPTTT}
                        </c:if>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Nút điều hướng -->
        <div class="mt-4 text-center">
            <a href="/api/quan-ly/hoa-don/view-hoa-don" class="btn btn-secondary">Quay lại danh sách</a>
        </div>
    </div>

    <!-- Bootstrap Tabs cho danh sách Chi Tiết Hóa Đơn -->
    <h4 class="text-center mt-4 text-info">Danh sách Chi Tiết Hóa Đơn</h4>
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#all">Tất cả</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#paid">Đã Thanh Toán</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#unpaid">Chưa Thanh Toán</a>
        </li>
    </ul>

    <div class="tab-content mt-3">
        <!-- Tất cả Chi Tiết Hóa Đơn -->
        <div class="tab-pane fade show active" id="all">
            <jsp:include page="table-hoa-don-chi-tiet.jsp" />
        </div>
        <!-- Chi Tiết Hóa Đơn Đã Thanh Toán -->
        <div class="tab-pane fade" id="paid">
            <jsp:include page="table-hoa-don-chi-tiet.jsp">
                <jsp:param name="filter" value="1"/>
            </jsp:include>
        </div>
        <!-- Chi Tiết Hóa Đơn Chưa Thanh Toán -->
        <div class="tab-pane fade" id="unpaid">
            <jsp:include page="table-hoa-don-chi-tiet.jsp">
                <jsp:param name="filter" value="0"/>
            </jsp:include>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
