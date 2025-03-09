<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi Tiết Sản Phẩm (Chế độ Xem)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Nếu không cần các hàm xử lý chỉnh sửa, bạn có thể loại bỏ các chức năng JavaScript không cần thiết.
        function previewImages() {
            // Không cần dùng vì file upload đã bị vô hiệu hóa
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
            cursor: not-allowed; /* Thay đổi giao diện vì đã disable */
        }
        /* CSS cho overlay loading */
        #loadingOverlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>

<!-- Overlay loading (không cần thiết nếu ở chế độ read-only) -->
<div id="loadingOverlay">
    <div class="spinner-border text-light" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<div class="container mt-4">
    <h2 class="text-info text-center">Chi Tiết Sản Phẩm (Chế độ Xem)</h2>
    <div class="card shadow-lg p-4">
        <!-- Nếu không cần submit thì có thể loại bỏ form hoặc thay đổi action -->
        <form action="#" method="post">
            <!-- Thông tin liên quan đến sản phẩm cha (dữ liệu ẩn, không cần chỉnh sửa) -->
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
                    <textarea name="moTa" class="form-control" rows="3" readonly>${quanJeansChiTiet.moTa}</textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="number" name="gia" class="form-control" step="0.01" value="${quanJeansChiTiet.gia}" readonly required>
                </div>
            </div>

            <!-- Chọn Màu sắc, Kích thước và Số lượng -->
            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Màu sắc:</label>
                    <select name="mauSac.id" class="form-select" disabled required>
                        <c:forEach var="mauSac" items="${listMauSac}">
                            <option value="${mauSac.id}" <c:if test="${mauSac.id == quanJeansChiTiet.mauSac.id}">selected</c:if>>
                                    ${mauSac.tenMauSac}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Kích thước:</label>
                    <select name="size.id" class="form-select" disabled required>
                        <c:forEach var="size" items="${listSize}">
                            <option value="${size.id}" <c:if test="${size.id == quanJeansChiTiet.size.id}">selected</c:if>>
                                    ${size.tenSize}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Số lượng:</label>
                    <input type="number" name="soLuong" class="form-control" min="1" value="${quanJeansChiTiet.soLuong}" readonly required>
                </div>
            </div>

            <!-- Hàng chứa hình ảnh hiện có và cụm trạng thái -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <!-- Danh sách hình ảnh hiện có -->
                <div class="d-flex flex-wrap">
                    <c:forEach var="hinhAnh" items="${listHinhAnh}">
                        <div class="image-container" id="image-${hinhAnh.id}">
                            <!-- Nút xóa đã được disable -->
                            <button type="button" class="delete-icon" disabled>&times;</button>
                            <img src="${hinhAnh.url}" class="img-thumbnail image-preview" alt="Hình ảnh sản phẩm">
                        </div>
                    </c:forEach>
                </div>
                <!-- Cụm trạng thái: hiển thị label và 2 radio button -->
                <div class="d-flex align-items-center">
                    <span class="fw-bold me-2">Trạng thái:</span>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="trangThai" id="trangThai0" value="0"
                               <c:if test="${quanJeansChiTiet.trangThai == 0}">checked</c:if> disabled>
                        <label class="form-check-label" for="trangThai0">Không hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="trangThai" id="trangThai1" value="1"
                               <c:if test="${quanJeansChiTiet.trangThai == 1}">checked</c:if> disabled>
                        <label class="form-check-label" for="trangThai1">Hoạt động</label>
                    </div>
                </div>
            </div>



            <div id="imagePreview" class="d-flex flex-wrap mt-3"></div>

            <!-- Nút chỉ quay lại (không có nút submit do ở chế độ xem) -->
            <div class="mt-4 text-center">
                <button type="button" class="btn btn-secondary" onclick="window.history.back();">Quay lại</button>
            </div>

        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
