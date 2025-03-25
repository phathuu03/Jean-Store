<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-info">Đơn Hàng Khách Hàng : ${hd[0].khachHang.tenKhachHang}</h2>
    <div class="card p-4 shadow-sm">
        <table class="table table-bordered text-center">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Mã Hóa Đơn</th>
                <th>Ngày tạo</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody id="orderTable">
            <c:forEach var="order" items="${hd}">
                <tr data-status="${order.trangThai}">
                    <td>${order.id}</td>
                    <td>${order.maHoaDon}</td>
                    <td>
                        <fmt:formatDate value="${order.ngayTao}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td><fmt:formatNumber value="${order.thanhTien}" type="currency" currencySymbol="đ"/></td>
                    <td>
                        <span class="badge bg-primary">${order.trangThai}</span>
                    </td>
                    <td>
                        <a href="/khach-hang/viewDetailDonHang/${order.id}" class="btn btn-info btn-sm">Xem</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
