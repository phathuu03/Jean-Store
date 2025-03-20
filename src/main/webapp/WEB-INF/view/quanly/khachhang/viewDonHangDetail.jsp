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
    <h2 class="text-info">Chi Tiết Đơn Hàng Khách Hàng</h2>

    <table class="table table-bordered">
        <tr>
            <th>Mã hóa đơn:</th>
            <td>${hd.maHoaDon}</td>
        </tr>
        <tr>
            <th>Khách hàng:</th>
            <td>${hd.khachHang.tenKhachHang}</td>
        </tr>
        <tr>
            <th>Ngày tạo:</th>
            <td><fmt:formatDate value="${hd.ngayTao}" pattern="dd/MM/yyyy"/></td>
        </tr>
        <tr>
            <th>Tổng tiền:</th>
            <td><fmt:formatNumber value="${hd.tongTien}" type="currency" currencySymbol="đ"/></td>
        <tr>
            <th>Phí ship:</th>
            <td><fmt:formatNumber value="${hd.phiShip}" type="currency" currencySymbol="đ"/></td>
        <tr>
            <th>Giảm giá:</th>
            <td><fmt:formatNumber value="${hd.giamGia}" type="currency" currencySymbol="đ"/></td>
        <tr>
            <th>Thành Tiền:</th>
            <td><fmt:formatNumber value="${hd.thanhTien}" type="currency" currencySymbol="đ"/></td>
        <tr>
            <th>Địa chỉ nhận hàng:</th>
            <td>${hd.diaChiGiaoHang}</td>
        </tr>
        <tr>
            <th>Trạng thái:</th>
            <td>
                <span class="badge bg-primary">${hd.trangThai}</span>
            </td>
        </tr>
    </table>

    <h4 class="mt-4">Danh sách sản phẩm:</h4>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Sản phẩm</th>
            <th>Hình ảnh</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Size</th>
            <th>Màu sắc</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${hd.hoaDonChiTiets}">
            <tr>
                <td>${item.quanJeansChiTiet.quanJeans.tenSanPham}</td>
                <c:forEach var="ha" items="${item.quanJeansChiTiet.quanJeans.hinhAnh}">
                    <c:if test="${ha.idMauSac==item.quanJeansChiTiet.mauSac.id}">
                        <td><img src="${ha.url}" width="50px" height="50px" alt="Ảnh sản phẩm"></td>
                    </c:if>
                </c:forEach>
                <td>${item.soLuong}</td>
                <td>${item.quanJeansChiTiet.gia} VNĐ</td>
                <td>${item.quanJeansChiTiet.size.tenSize}</td>
                <td>${item.quanJeansChiTiet.mauSac.tenMauSac}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a onclick="back()" class="btn btn-secondary">Quay lại</a>
</div>
<script>
    function back() {
        history.back()
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
