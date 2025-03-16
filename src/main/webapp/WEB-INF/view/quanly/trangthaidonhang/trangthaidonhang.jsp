<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý trạng thái đơn hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-bottom: 80px; /* Dành không gian cho phân trang cố định ở dưới */
        }
        h2 {
            margin-top: 20px;
        }

        /* Phân trang cố định ở cuối trang */
        .pagination-container {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
            padding: 10px 0;
            z-index: 100;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center text-muted mb-4">Quản Lý Trạng Thái Đơn Hàng</h2>

    <!-- Phần Tìm kiếm -->
    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/quanly/don-hang" class="d-flex">
            <input type="text" name="search" class="form-control form-control-sm" placeholder="Nhập từ khóa..." value="${search}">
            <button class="btn btn-primary btn-sm ms-2" type="submit">
                <i class="bi bi-search"></i> Tìm kiếm
            </button>
        </form>
    </div>

    <!-- Bảng hiển thị hóa đơn -->
    <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
            <td>STT</td>
            <th>Mã Hóa Đơn</th>
            <th>Phí Ship</th>
            <th>Giảm Giá</th>
            <th>Thành Tiền</th>
            <th>Tổng Tiền</th>
            <th>Địa Chỉ Giao Hàng</th>
            <th>Ngày Tạo</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${hoaDons}" var="hoadon" varStatus="item">
            <tr>
                <td>${item.index + 1} </td>
                <td>${hoadon.maHoaDon}</td>
                <td>${hoadon.phiShip}</td>
                <td>${hoadon.giamGia}</td>
                <td>${hoadon.thanhTien}</td>
                <td>${hoadon.tongTien}</td>
                <td>${hoadon.diaChiGiaoHang}</td>
                <td><fmt:formatDate value="${hoadon.ngayTao}" pattern="dd/MM/yyyy"/></td>
                <td>${hoadon.trangThai}</td>
                <td>
                    <a href="/view/detai-trang-thai/${hoadon.id}" class="btn btn-sm btn-info">Xem trạng thái đơn hàng</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Phân trang cố định -->
<div class="pagination-container d-flex justify-content-center mt-4">
    <!-- Trang đầu -->
    <c:if test="${currentPage > 0}">
        <a href="/quanly/don-hang?page=0&size=5&search=${search}" class="btn btn-outline-primary me-2">Trang đầu</a>
    </c:if>

    <!-- Trang trước -->
    <c:if test="${currentPage > 0}">
        <a href="/quanly/don-hang?page=${currentPage - 1}&size=5&search=${search}" class="btn btn-outline-primary me-2">Trang trước</a>
    </c:if>

    <!-- Trang hiện tại -->
    <span class="btn btn-outline-secondary me-2">Trang ${currentPage + 1} / ${totalPages}</span>

    <!-- Trang tiếp theo -->
    <c:if test="${currentPage < totalPages - 1}">
        <a href="/quanly/don-hang?page=${currentPage + 1}&size=5&search=${search}" class="btn btn-outline-primary me-2">Trang tiếp theo</a>
    </c:if>

    <!-- Trang cuối -->
    <c:if test="${currentPage < totalPages - 1}">
        <a href="/quanly/don-hang?page=${totalPages - 1}&size=5&search=${search}" class="btn btn-outline-primary">Trang cuối</a>
    </c:if>
</div>

<!-- Bootstrap JS Bundle (bao gồm Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
