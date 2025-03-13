<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lý Hóa Đơn</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h2 {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center text-muted mb-4">Quản Lý Hóa Đơn</h2>

    <!-- Phần Tìm kiếm -->
    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/api/hoadon/hoadon-search" class="d-flex">
            <input type="text" name="search" class="form-control form-control-sm" placeholder="Nhập từ khóa..." value="${param.search}">
            <button class="btn btn-primary btn-sm ms-2" type="submit">
                <i class="bi bi-search"></i> Tìm kiếm
            </button>
        </form>
    </div>

    <!-- Nav tabs -->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#all">Tất cả hóa đơn</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#tab0">Chờ xác nhận</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#tab1">Chờ giao hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#tab2">Đang giao hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#tab3">Hoàn thành</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#tab4">Đã hủy</a>
        </li>
    </ul>

    <!-- Nội dung các tab -->
    <div class="tab-content mt-3">
        <!-- Tab: Tất cả hóa đơn -->
        <div class="tab-pane fade show active" id="all">
            <jsp:include page="table-hoa-don.jsp" />
        </div>
        <!-- Tab trạng thái 0: Chờ xác nhận -->
        <div class="tab-pane fade" id="tab0">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="0"/>
            </jsp:include>
        </div>
        <!-- Tab trạng thái 1: Chờ giao hàng -->
        <div class="tab-pane fade" id="tab1">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="1"/>
            </jsp:include>
        </div>
        <!-- Tab trạng thái 2: Đang giao hàng -->
        <div class="tab-pane fade" id="tab2">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="2"/>
            </jsp:include>
        </div>
        <!-- Tab trạng thái 3: Hoàn thành -->
        <div class="tab-pane fade" id="tab3">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="3"/>
            </jsp:include>
        </div>
        <!-- Tab trạng thái 4: Đã hủy -->
        <div class="tab-pane fade" id="tab4">
            <jsp:include page="table-hoa-don.jsp">
                <jsp:param name="filter" value="4"/>
            </jsp:include>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle (bao gồm Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
