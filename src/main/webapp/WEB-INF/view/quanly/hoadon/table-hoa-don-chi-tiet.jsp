<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Lấy giá trị filter từ request; nếu không có thì mặc định là "all" -->
<c:set var="filter" value="${not empty param.filter ? param.filter : 'all'}" />

<table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
        <th>ID</th>
        <th>Tên sản phẩm</th>
        <th>Số Lượng</th>
        <th>Đơn Giá</th>
        <th>Tổng Tiền</th>
        <th>Ngày Tạo</th>
        <th>Ngày Sửa</th>
        <th>Trạng Thái</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="hdct" items="${listHdct}">
        <c:if test="${empty param.filter || hdct.trangThai == param.filter}">
            <tr>
                <td>${hdct.id}</td>
                <td>${hdct.quanJeansChiTiet.quanJeans.tenSanPham}</td>
                <td>${hdct.soLuong}</td>
                <td>${hdct.donGia}</td>
                <td>${hdct.tongTien}</td>
                <td>
                    <fmt:formatDate value="${hdct.ngayTao}" pattern="dd/MM/yyyy" />
                </td>
                <td>
                    <fmt:formatDate value="${hdct.ngaySua}" pattern="dd/MM/yyyy" />
                </td>
                <td>
                        ${hdct.trangThai == 0 ? "Chưa Thanh Toán" : "Đã Thanh Toán"}
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
