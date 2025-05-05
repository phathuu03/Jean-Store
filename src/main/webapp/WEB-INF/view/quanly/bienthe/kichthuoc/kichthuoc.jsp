<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Kích Thước</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            flex: 1;
        }

        .pagination-container {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
            padding: 10px 0;
            z-index: 100;
        }

        h3 {
            margin-bottom: 0;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">Quản lý Kích Thước</h3>
        </div>
        <div class="card-body">
            <!-- Hiển thị lỗi nếu có -->
            <div class="mt-4 text-center">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
            </div>

            <form action="/api/quan-ly/add-size" method="post" class="mb-4 row g-3 align-items-center">
                <div class="col-md-8">
                    <input type="text" class="form-control" name="tenSize" placeholder="Nhập tên kích thước" required>
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
                        <th>Tên Kích Thước</th>
                        <th>Trạng Thái</th>
                        <th>Ngày tạo</th>
                        <th>Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="size" items="${sizeList}">
                        <tr>
                            <td>${size.tenSize}</td>
                            <td>
                                <span class="badge ${size.trangThai == 1 ? 'bg-success' : 'bg-danger'}">
                                        ${size.trangThai == 1 ? 'Hoạt động' : 'Không hoạt động'}
                                </span>
                            </td>
                            <td><fmt:formatDate value="${size.ngayTao}" pattern="dd/MM/yyyy" /></td>
                            <td class="action-buttons">
                                <a href="/api/quan-ly/edit-size/${size.id}" class="btn btn-primary btn-sm w-100">Sửa</a>
                                <a href="/api/quan-ly/deactivate-size/${size.id}" class="btn btn-warning btn-sm w-100">Thay đổi trạng thái</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Phân trang cố định -->
<div class="pagination-container">
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <!-- Trang đầu -->
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="?page=0&size=10">Trang đầu</a>
                </li>
            </c:if>

            <!-- Trang trước -->
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage - 1}&size=10">Trang trước</a>
                </li>
            </c:if>

            <!-- Các trang số -->
            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}&size=10">${i + 1}</a>
                </li>
            </c:forEach>

            <!-- Trang tiếp theo -->
            <c:if test="${currentPage < totalPages - 1}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage + 1}&size=10">Trang tiếp theo</a>
                </li>
            </c:if>

            <!-- Trang cuối -->
            <c:if test="${currentPage < totalPages - 1}">
                <li class="page-item">
                    <a class="page-link" href="?page=${totalPages - 1}&size=10">Trang cuối</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

</body>
</html>
