<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    th {
        white-space: nowrap;
    }
</style>
<table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
        <th>ID</th>
        <th>Tổng Tiền</th>
        <th>Địa Chỉ Giao Hàng</th>
        <th>Ngày Thanh Toán</th>
        <th>Trạng Thái</th>
        <th>Khách Hàng</th>
        <th>Nhân Viên</th>
        <th>Voucher</th>
        <th>Phương Thức Thanh Toán</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="hoaDon" items="${listHoaDon}">
        <c:if test="${empty param.filter || hoaDon.trangThai == param.filter}">
            <tr>
                <td>${hoaDon.id}</td>
                <td>${hoaDon.tongTien}</td>
                <td>${hoaDon.diaChiGiaoHang}</td>
                <td>
                    <c:if test="${hoaDon.ngayThanhToan != null}">
                        ${hoaDon.ngayThanhToan}
                    </c:if>
                </td>
                <td>
                        ${hoaDon.trangThai == 0 ? "Chưa Thanh Toán" : "Đã Thanh Toán"}
                </td>
                <td>
                    <c:if test="${hoaDon.khachHang != null}">
                        ${hoaDon.khachHang.tenKhachHang}
                    </c:if>
                </td>
                <td>
                    <c:if test="${hoaDon.nhanVien != null}">
                        ${hoaDon.nhanVien.tenNhanVien}
                    </c:if>
                </td>
                <td>
                    <c:if test="${hoaDon.voucher != null}">
                        ${hoaDon.voucher.tenVoucher}
                    </c:if>
                </td>
                <td>
                    <c:if test="${hoaDon.pttt != null}">
                        ${hoaDon.pttt.tenPTTT}
                    </c:if>
                </td>
                <td>
                    <!-- Chỉ giữ lại nút Detail -->
                    <a href="view/detail/${hoaDon.id}" class="btn btn-info btn-sm">
                        <i class="bi bi-eye-fill"></i> Detail
                    </a>
                </td>
            </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
