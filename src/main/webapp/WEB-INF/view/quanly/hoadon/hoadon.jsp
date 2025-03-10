<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lý Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-info">Quản Lý Hóa Đơn</h2>

    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/api/hoadon/hoadon-search" class="d-flex">
            <input type="text" name="search" class="form-control form-control-sm" placeholder="Nhập từ khóa..." value="${param.search}">
            <button class="btn btn-primary btn-sm ms-2" type="submit">Tìm kiếm</button>
        </form>
        <!-- Phần Thêm Mới đã được loại bỏ -->
    </div>

    <!-- Nav tabs phân theo trạng thái hóa đơn -->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#all">Tất cả hóa đơn</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#paid">Đã Thanh Toán</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#unpaid">Chưa Thanh Toán</a>
        </li>
    </ul>

    <div class="tab-content mt-3">
        <!-- Hiển thị tất cả hóa đơn -->
        <div class="tab-pane fade show active" id="all">
            <jsp:include page="table-hoa-don.jsp" />
        </div>
        <!-- Hiển thị hóa đơn Đã Thanh Toán, truyền filter=1 -->
        <div class="tab-pane fade" id="paid">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="1"/>
            </jsp:include>
        </div>
        <!-- Hiển thị hóa đơn Chưa Thanh Toán, truyền filter=0 -->
        <div class="tab-pane fade" id="unpaid">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="0"/>
            </jsp:include>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
