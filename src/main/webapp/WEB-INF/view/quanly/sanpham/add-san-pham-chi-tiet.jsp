<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function previewImages() {
            var fileInput = document.getElementById("imageFiles");
            var previewContainer = document.getElementById("imagePreview");
            previewContainer.innerHTML = "";
            for (var i = 0; i < fileInput.files.length; i++) {
                var file = fileInput.files[i];
                var reader = new FileReader();
                reader.onload = function(event) {
                    var img = document.createElement("img");
                    img.src = event.target.result;
                    img.classList.add("img-thumbnail", "m-2", "image-preview");
                    previewContainer.appendChild(img);
                }
                reader.readAsDataURL(file);
            }
        }
    </script>
    <style>
        .image-preview {
            width: 100px;
            height: auto;
            margin-right: 10px;
        }
        #imagePreview {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
            padding: 5px;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <h2 class="text-info text-center">Thêm Chi Tiết Sản Phẩm</h2>

    <div class="card shadow-lg p-4">
        <form action="${pageContext.request.contextPath}/api/quan-jeans-chi-tiet/add" method="post" enctype="multipart/form-data">
            <input type="hidden" name="quanJeans.id" value="${quanJeans.id}">

            <h4 class="text-primary">Thông Tin Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-3">
                    <label class="fw-bold">Tên sản phẩm:</label>
                    <p class="form-control-plaintext">${quanJeans.tenSanPham}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Thương hiệu:</label>
                    <p class="form-control-plaintext">${quanJeans.thuongHieu.tenThuongHieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Chất liệu:</label>
                    <p class="form-control-plaintext">${quanJeans.chatLieu.tenChatLieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Ống quần:</label>
                    <p class="form-control-plaintext">${quanJeans.ongQuan.tenOngQuan}</p>
                </div>
            </div>

            <h4 class="text-primary">Chi Tiết Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Mô tả:</label>
                    <textarea name="moTa" class="form-control" rows="3" ></textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="number" name="gia" class="form-control" step="0.01" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Màu sắc:</label>
                    <select name="mauSac.id" class="form-select" required>
                        <c:forEach var="mauSac" items="${listMauSac}">
                            <option value="${mauSac.id}">${mauSac.tenMauSac}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Kích thước:</label>
                    <select name="size.id" class="form-select" required>
                        <c:forEach var="size" items="${listSize}">
                            <option value="${size.id}">${size.tenSize}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Số lượng:</label>
                    <input type="number" name="soLuong" class="form-control" min="1" required>
                </div>
            </div>

            <!-- Phần chọn trạng thái -->
            <div class="row mb-3">
                <div class="col-md-12">
                    <label class="fw-bold">Trạng thái:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="trangThai" id="trangThai0" value="0">
                        <label class="form-check-label" for="trangThai0">Không hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="trangThai" id="trangThai1" value="1" checked>
                        <label class="form-check-label" for="trangThai1">Hoạt động</label>
                    </div>
                </div>
            </div>

            <h4 class="text-primary">Hình Ảnh</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Chọn hình ảnh:</label>
                    <input type="file" name="imageFiles" id="imageFiles" class="form-control" multiple  onchange="previewImages()">
                </div>
            </div>
            <div id="imagePreview" class="d-flex flex-wrap mt-3"></div>

            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Lưu Chi Tiết</button>
                <a href="${pageContext.request.contextPath}/api/quan-jean/detail/${quanJeans.id}" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
