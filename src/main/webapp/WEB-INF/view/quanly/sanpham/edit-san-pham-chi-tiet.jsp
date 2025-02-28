<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh Sửa Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function previewImages() {
            var fileInput = document.getElementById("imageFiles");
            var previewContainer = document.getElementById("imagePreview");
            previewContainer.innerHTML = "";
            for (var i = 0; i < fileInput.files.length; i++) {
                var file = fileInput.files[i];
                var reader = new FileReader();
                reader.onload = function (event) {
                    var img = document.createElement("img");
                    img.src = event.target.result;
                    img.classList.add("img-thumbnail", "m-2", "image-preview");
                    img.style.width = "80px";
                    img.style.height = "80px";
                    previewContainer.appendChild(img);
                }
                reader.readAsDataURL(file);
            }
        }

        // Danh sách chứa ID các hình ảnh sẽ xóa khi người dùng lưu thay đổi
        var deletedImageList = [];

        function deleteImage(imageId) {
            if (confirm("Bạn có chắc muốn xóa hình ảnh này không?")) {
                deletedImageList.push(imageId);
                // Cập nhật giá trị của input ẩn với danh sách ID hình ảnh đã xóa
                document.getElementById('deletedImages').value = JSON.stringify(deletedImageList);
                // Xóa container chứa hình ảnh đó khỏi giao diện
                document.getElementById('image-' + imageId).remove();
            }
        }
    </script>
    <style>
        .image-preview {
            width: 80px;
            height: 80px;
        }
        .image-container {
            position: relative;
            margin-right: 10px;
            margin-bottom: 10px;
        }
        .delete-icon {
            position: absolute;
            top: -5px;
            right: -5px;
            background: red;
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="text-info text-center">Chỉnh Sửa Chi Tiết Sản Phẩm</h2>
    <div class="card shadow-lg p-4">
        <form action="${pageContext.request.contextPath}/api/quan-jeans-chi-tiet/update/${quanJeansChiTiet.id}"
              method="post" enctype="multipart/form-data">
            <!-- Thông tin liên quan đến sản phẩm cha -->
            <input type="hidden" name="quanJeans.id" value="${quanJeansChiTiet.quanJeans.id}">
            <!-- Input ẩn để lưu danh sách ID hình ảnh sẽ xóa -->
            <input type="hidden" id="deletedImages" name="deletedImages" value="[]">

            <!-- Thông tin Sản Phẩm -->
            <h4 class="text-primary">Thông Tin Sản Phẩm</h4>
            <div class="row mb-3">
                <div class="col-md-3">
                    <label class="fw-bold">Tên sản phẩm:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.tenSanPham}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Thương hiệu:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.thuongHieu.tenThuongHieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Chất liệu:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.chatLieu.tenChatLieu}</p>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Ống quần:</label>
                    <p class="form-control-plaintext">${quanJeansChiTiet.quanJeans.ongQuan.tenOngQuan}</p>
                </div>
            </div>

            <!-- Thông tin Sản Phẩm Chi Tiết -->
            <h4 class="text-primary">Thông Tin Sản Phẩm Chi Tiết</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Mô tả:</label>
                    <textarea name="moTa" class="form-control" rows="3" >${quanJeansChiTiet.moTa}</textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="number" name="gia" class="form-control" step="0.01" value="${quanJeansChiTiet.gia}" required>
                </div>
            </div>

            <!-- Chọn Màu sắc, Kích thước và Số lượng -->
            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Màu sắc:</label>
                    <select name="mauSac.id" class="form-select" required>
                        <c:forEach var="mauSac" items="${listMauSac}">
                            <option value="${mauSac.id}" <c:if test="${mauSac.id == quanJeansChiTiet.mauSac.id}">selected</c:if>>
                                    ${mauSac.tenMauSac}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Kích thước:</label>
                    <select name="size.id" class="form-select" required>
                        <c:forEach var="size" items="${listSize}">
                            <option value="${size.id}" <c:if test="${size.id == quanJeansChiTiet.size.id}">selected</c:if>>
                                    ${size.tenSize}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Số lượng:</label>
                    <input type="number" name="soLuong" class="form-control" min="1" value="${quanJeansChiTiet.soLuong}" required>
                </div>
            </div>

            <!-- Hàng chứa hình ảnh hiện có và cụm trạng thái (đều nằm trên cùng 1 dòng) -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <!-- Danh sách hình ảnh hiện có -->
                <div class="d-flex flex-wrap">
                    <c:forEach var="hinhAnh" items="${listHinhAnh}">
                        <div class="image-container" id="image-${hinhAnh.id}">
                            <button type="button" class="delete-icon" onclick="deleteImage(${hinhAnh.id})">&times;</button>
                            <img src="${hinhAnh.url}" class="img-thumbnail image-preview" alt="Hình ảnh sản phẩm">
                        </div>
                    </c:forEach>
                </div>
                <!-- Cụm trạng thái: hiển thị label và 2 radio button trên cùng 1 dòng -->
                <div class="d-flex align-items-center">
                    <span class="fw-bold me-2">Trạng thái:</span>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="trangThai" id="trangThai0" value="0"
                               <c:if test="${quanJeansChiTiet.trangThai == 0}">checked</c:if>>
                        <label class="form-check-label" for="trangThai0">Không hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="trangThai" id="trangThai1" value="1"
                               <c:if test="${quanJeansChiTiet.trangThai == 1}">checked</c:if>>
                        <label class="form-check-label" for="trangThai1">Hoạt động</label>
                    </div>
                </div>
            </div>

            <!-- Thêm Hình Ảnh mới -->
            <h4 class="text-primary">Thêm Hình Ảnh</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Chọn hình ảnh:</label>
                    <input type="file" name="imageFiles" id="imageFiles" class="form-control" multiple onchange="previewImages()">
                </div>
            </div>
            <div id="imagePreview" class="d-flex flex-wrap mt-3"></div>

            <!-- Nút Submit & Hủy -->
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary">Cập Nhật Chi Tiết</button>
                <a href="${pageContext.request.contextPath}/api/quan-jean/detail/${quanJeansChiTiet.quanJeans.id}" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
