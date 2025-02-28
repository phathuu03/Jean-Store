<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Màu Sắc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-4">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0 text-info">Quản lý Màu Sắc</h3>
        </div>
        <div class="card-body">
            <form action="/api/quan-ly/add-mau-sac" method="post" class="mb-4 row g-3 align-items-center">
                <div class="col-md-8">
                    <input type="text" class="form-control" name="tenMauSac" placeholder="Nhập tên màu sắc" required>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="trangThai" required>
                        <option value="1">Hoạt động</option>
                        <option value="0">Không hoạt động</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-success w-100">Thêm</button>
                </div>
            </form>
            <div class="table-responsive">
                <table class="table table-hover table-striped table-bordered">
                    <thead class="table-dark">
                    <tr>
                        <th>Tên Màu Sắc</th>
                        <th>Trạng Thái</th>
                        <th>Ngày tạo</th>
                        <th>Ngày sửa</th>
                        <th>Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="mauSac" items="${listMauSac}">
                        <tr>
                            <td>${mauSac.tenMauSac}</td>
                            <td>
                                <span class="badge ${mauSac.trangThai == 1 ? 'bg-success' : 'bg-danger'}">
                                        ${mauSac.trangThai == 1 ? 'Hoạt động' : 'Không hoạt động'}
                                </span>
                            </td>

                            <td><fmt:formatDate value="${mauSac.ngayTao}" pattern="dd/MM/yyyy" /></td>
                            <td><fmt:formatDate value="${mauSac.ngaySua}" pattern="dd/MM/yyyy" /></td>

                            <td>
                                <a href="/api/quan-ly/edit-mau-sac/${mauSac.id}" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="/api/quan-ly/deactivate-mau-sac/${mauSac.id}" class="btn btn-danger btn-sm">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
<%--                <div class="container mt-4">--%>
<%--                    <nav aria-label="Page navigation">--%>
<%--                        <ul class="pagination justify-content-center">--%>
<%--                            <c:forEach var="i" begin="0" end="${totalPages - 1}">--%>
<%--                                <li class="page-item ${i == currentPage ? 'active' : ''}">--%>
<%--                                    <a class="page-link" href="?page=${i}">${i + 1}</a>--%>
<%--                                </li>--%>
<%--                            </c:forEach>--%>
<%--                        </ul>--%>
<%--                    </nav>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</div>
</body>
</html>
