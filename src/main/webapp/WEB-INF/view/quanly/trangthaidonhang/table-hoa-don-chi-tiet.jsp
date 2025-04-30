<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Lấy giá trị filter từ request; nếu không có thì mặc định là "all" -->
<c:set var="filter" value="${not empty param.filter ? param.filter : 'all'}" />

<table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
        <th>Mã sản phẩm</th>
        <th>Tên sản phẩm</th>
        <th>Số Lượng</th>
        <th>Đơn Giá</th>
        <th>Tổng tiền</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="hdct" items="${listHdct}">
        <c:if test="${empty param.filter || hdct.trangThai == param.filter}">
            <tr>
                <td>${hdct.quanJeansChiTiet.quanJeans.maSanPham}</td>
                <td>${hdct.quanJeansChiTiet.quanJeans.tenSanPham}</td>
                <td>${hdct.soLuong}</td>
                <td><fmt:formatNumber value="${hdct.donGia}" pattern="#,### VND"/>
                </td>
                <td><fmt:formatNumber value="${hdct.tongTien}" pattern="#,### VND"/>
                </td>
                <td>
                    <!-- Giữ lại nút Detail (có thể bổ sung thêm hành động nếu cần) -->
                    <a href="/api/quan-ly/hoa-don/view/hoa-don-chi-tiet/${hdct.id}" class="btn btn-info btn-sm">
                        <i class="bi bi-eye-fill"></i> Detail
                    </a>
                </td>
            </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
