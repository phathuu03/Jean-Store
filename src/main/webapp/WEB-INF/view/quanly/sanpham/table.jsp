<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
        <th>ID</th>
        <th>Tên Sản Phẩm</th>
        <th>Ngày Tạo</th>
        <th>Ngày Sửa</th>
        <th>Trạng Thái</th>
        <th>Thương hiệu</th>
        <th>Chất Liệu</th>
        <th>Ống Quần</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="quanJeans" items="${listQuanJean}">
        <c:if test="${empty param.filter || quanJeans.trangThai == param.filter}">
            <tr>
                <td>${quanJeans.id}</td>
                <td>${quanJeans.tenSanPham}</td>
                <td>${quanJeans.ngayTao}</td>
                <td>${quanJeans.ngaySua}</td>
                <td>${quanJeans.trangThai == 0 ? "Còn hàng" : "Hết hàng"}</td>
                <td>${quanJeans.thuongHieu.tenThuongHieu}</td>
                <td>${quanJeans.chatLieu.tenChatLieu}</td>
                <td>${quanJeans.ongQuan.tenOngQuan}</td>
                <td class="d-flex gap-2">
                    <!-- Nút xem chi tiết -->
                    <a href="detail/${quanJeans.id}" class="btn btn-info btn-sm">
                        <i class="bi bi-eye-fill"></i> Detail
                    </a>
                    <!-- Nút chỉnh sửa -->
                    <a href="edit/${quanJeans.id}" class="btn btn-primary btn-sm">
                        <i class="bi bi-pencil-square"></i> Chỉnh sửa
                    </a>
                    <!-- Nút xóa -->
                    <a href="delete/${quanJeans.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">
                        <i class="bi bi-trash"></i> Xóa
                    </a>
                </td>
            </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
