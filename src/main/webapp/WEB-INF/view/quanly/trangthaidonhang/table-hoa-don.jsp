<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* Giữ lại white-space cho header nếu cần */
    th {
        white-space: nowrap;
    }

    /* Tùy chỉnh giao diện bảng */
    .custom-table {
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        overflow: hidden;
    }

    .custom-table thead.table-dark {
        background-color: #343a40;
    }

    /* Tùy chỉnh nút Detail với padding */
    .detail-btn {
        padding: 0.5rem 1rem;
        font-size: 0.875rem;
    }
</style>

<div class="table-responsive">
    <table class="table table-bordered table-striped custom-table">
        <thead class="table-dark">
        <tr>
            <th>Mã hóa đơn</th>
            <th>Tổng Tiền</th>
            <th>Phí ship</th>
            <th>Giảm giá</th>
            <th>Thành tiền</th>
            <th>Trạng Thái</th>
            <th>Khách Hàng</th>
            <th>Hành động</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach var="hoaDon" items="${listHoaDon}">
            <c:if test="${empty param.filter || hoaDon.publicTrangThai == param.filter}">
                <tr>
                    <td>${hoaDon.maHoaDon}</td>
                    <td><fmt:formatNumber value="${hoaDon.tongTien}" pattern="#,### VND"/></td>
                    <td><fmt:formatNumber value="${hoaDon.phiShip}" pattern="#,### VND"/></td>
                    <td><fmt:formatNumber value="${hoaDon.giamGia}" pattern="#,### VND" /></td>
                    <td><fmt:formatNumber value="${hoaDon.thanhTien}" pattern="#,### VND" /></td>
                    <td>${hoaDon.trangThai}</td>
                    <td>
                        <c:if test="${hoaDon.khachHang != null}">
                            ${hoaDon.khachHang.tenKhachHang}
                        </c:if>
                    </td>
                    <td>
                        <a href="http://localhost:8080/view/detai-trang-thai/${hoaDon.id}" class="btn btn-sm btn-info">Cập nhật trạng thái đơn hàng</a>

                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
</div>
