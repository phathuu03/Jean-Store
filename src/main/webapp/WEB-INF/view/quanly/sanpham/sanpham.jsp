<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Quần Jeans</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .error {
            color: red;
        }
    </style>
    <script>
        function toggleForm() {
            var form = document.getElementById("addForm");
            var toggleButton = document.getElementById("toggleButton");
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block";
                toggleButton.textContent = "Ẩn Form";
            } else {
                form.style.display = "none";
                toggleButton.textContent = "Thêm mới";
            }
        }
    </script>
</head>
<body>
<div class="container mt-4">
    <h2 class="text-info">Quản lý Quần Jeans</h2>

    <div class="d-flex align-items-center justify-content-between mb-3">
        <form action="/api/quan-jean/quanjeans-search" class="d-flex">
            <input type="text" name="search" class="form-control form-control-sm" placeholder="Nhập từ khóa..." value="${param.search}">
            <button class="btn btn-primary btn-sm ms-2" type="submit">Tìm kiếm</button>
        </form>
        <button id="toggleButton" class="btn btn-success" onclick="toggleForm()">Thêm mới</button>
    </div>

    <!-- Sử dụng requestScope để kiểm tra BindingResult của 'quanJeans' -->
    <c:set var="hasErrors" value="${not empty requestScope['org.springframework.validation.BindingResult.quanJeans']
        and requestScope['org.springframework.validation.BindingResult.quanJeans'].errorCount gt 0}" />

    <!-- Nếu có lỗi, hiển thị form; nếu không, form ẩn theo mặc định -->
    <div id="addForm" class="card shadow-lg p-4 mb-4" style="display: ${hasErrors ? 'block' : 'none'};">
        <!-- Sử dụng form:form để binding đối tượng quanJeans -->
        <form:form modelAttribute="quanJeans"
                   action="${quanJeans.id == null ? '/api/quan-jean/new-quan-jean' : 'update/' + quanJeans.id}"
                   method="post">
            <!-- Input ẩn cho id -->
            <form:hidden path="id"/>
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm:</label>
                        <!-- Binding với trường tenSanPham -->
                        <form:input path="tenSanPham" cssClass="form-control" />
                        <!-- Hiển thị lỗi validate nếu có -->
                        <form:errors path="tenSanPham" cssClass="error"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thương hiệu:</label>
                        <select name="thuongHieu.id" class="form-select">
                            <c:forEach var="thuongHieu" items="${listThuongHieu}">
                                <option value="${thuongHieu.id}" ${quanJeans.thuongHieu.id == thuongHieu.id ? 'selected' : ''}>
                                        ${thuongHieu.tenThuongHieu}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Ống quần:</label>
                        <select name="ongQuan.id" class="form-select">
                            <c:forEach var="ongQuan" items="${listOngQuan}">
                                <option value="${ongQuan.id}" ${quanJeans.ongQuan.id == ongQuan.id ? 'selected' : ''}>
                                        ${ongQuan.tenOngQuan}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chất liệu:</label>
                        <select name="chatLieu.id" class="form-select">
                            <c:forEach var="chatLieu" items="${listChatLieu}">
                                <option value="${chatLieu.id}" ${quanJeans.chatLieu.id == chatLieu.id ? 'selected' : ''}>
                                        ${chatLieu.tenChatLieu}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="d-flex gap-3 mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="trangThai" value="1" checked>
                            <label class="form-check-label">Hoạt động</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="trangThai" value="0">
                            <label class="form-check-label">Không hoạt động</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form:form>
    </div>

    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#all">Tất cả sản phẩm</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#available">Hoạt động</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#outofstock">Không hoạt động</a>
        </li>
    </ul>

    <div class="tab-content mt-3">
        <div class="tab-pane fade show active" id="all">
            <jsp:include page="table.jsp"/>
        </div>
        <div class="tab-pane fade" id="available">
            <jsp:include page="table.jsp">
                <jsp:param name="filter" value="1"/>
            </jsp:include>
        </div>
        <div class="tab-pane fade" id="outofstock">
            <jsp:include page="table.jsp">
                <jsp:param name="filter" value="0"/>
            </jsp:include>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
