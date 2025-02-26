<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa Quần Jeans</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center mb-4">Chỉnh sửa Quần Jeans</h2>

    <div class="card shadow-lg p-4">
        <form action="/api/quan-jean/update/${quanJeans.id}" method="post">
            <input type="hidden" name="id" value="${quanJeans.id}">

            <div class="row">
                <div class="col-md-6">
                    <h4 class="text-primary">Thông tin sản phẩm</h4>
                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm:</label>
                        <input type="text" name="tenSanPham" value="${quanJeans.tenSanPham}" class="form-control" required>
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
                    <div class="mb-3">
                        <label class="form-label">Trạng thái:</label>
                        <div class="d-flex gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="trangThai" value="0" ${quanJeans.trangThai == 0 ? 'checked' : ''}>
                                <label class="form-check-label">Không hoạt động</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="trangThai" value="1" ${quanJeans.trangThai == 1 ? 'checked' : ''}>
                                <label class="form-check-label">Hoạt động</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h4 class="text-success">Thông tin bổ sung</h4>
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
                </div>
            </div>
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <a href="/api/quan-jean/quanjeans" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
