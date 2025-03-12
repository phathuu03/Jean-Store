<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
        <th>ID</th>
        <th>Màu Sắc</th>
        <th>Size</th>
        <th>Giá</th>
        <th>Số Lượng</th>
        <th>Trạng Thái</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="chiTiet" items="${listQuanJeansChiTiet}">
        <c:if test="${empty param.filter || chiTiet.trangThai == param.filter}">
            <tr>
                <td>${chiTiet.id}</td>
                <td>${chiTiet.mauSac.tenMauSac}</td>
                <td>${chiTiet.size.tenSize}</td>
                <td>${chiTiet.gia} VND</td>
                <td>${chiTiet.soLuong}</td>
                <td>${chiTiet.trangThai == 0 ? "Không hoạt động" : "Hoạt động"}</td>
                <td>
                    <a href="/api/quan-jeans-chi-tiet/edit/${chiTiet.id}" class="btn btn-primary btn-sm">Chỉnh sửa</a>
                    <a href="/api/quan-jeans-chi-tiet/delete/${chiTiet.id}" class="btn btn-warning btn-sm">Thay đổi trạng thái</a>
                </td>
            </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
