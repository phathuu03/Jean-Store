<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Phiếu Giảm Giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
<div class="card p-4 shadow-sm">
    <h2 class="text-info">Update Voucher</h2>

    <form action="/voucher/update/${voucher.id}" method="post">
        <input type="hidden" name="id" value="${voucher.id}">

        <div class="mb-3">
            <label for="tenVoucher" class="form-label">Tên Phiếu Giảm Giá</label>
            <input type="text" id="tenVoucher" name="tenVoucher" class="form-control" value="${voucher.tenVoucher}" required>
        </div>

        <div class="mb-3">
            <label for="moTa" class="form-label">Mô Tả</label>
            <textarea id="moTa" name="moTa" class="form-control" rows="3" required>${voucher.moTa}</textarea>
        </div>

        <div class="mb-3">
            <label for="soLuong" class="form-label">Số Lượng</label>
            <input type="number" id="soLuong" name="soLuong" class="form-control" value="${voucher.soLuong}" min="1" required>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="phanTramGiamGia" class="form-label">Phần Trăm Giảm Giá</label>
                <input type="number" id="phanTramGiamGia" name="phanTramGiamGia" class="form-control" value="${voucher.phanTramGiamGia}" min="0" max="100" required>
            </div>

            <div class="col-md-6 mb-3">
                <label for="dieuKienApDung" class="form-label">Điều Kiện Áp Dụng</label>
                <input type="number" id="dieuKienApDung" name="dieuKienApDung" class="form-control"value="${voucher.dieuKienApDung}" placeholder="Nhập điều kiện áp dụng" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="giamGiaToiDa" class="form-label">Giảm Giá Tối Đa</label>
                <input type="number" id="giamGiaToiDa" name="giamGiaToiDa" class="form-control" value="${voucher.giamGiaToiDa}" step="0.01" required>
            </div>

            <div class="col-md-6 mb-3">
                <label for="ngayBatDau" class="form-label">Ngày Bắt Đầu</label>
                <input type="date" id="ngayBatDau" name="ngayBatDau" class="form-control" value="${voucher.ngayBatDau}" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="ngayKetThuc" class="form-label">Ngày Kết Thúc</label>
                <input type="date" id="ngayKetThuc" name="ngayKetThuc" class="form-control" value="${voucher.ngayKetThuc}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="trangThai" class="form-label">Trạng Thái</label>
                <select id="trangThai" name="trangThai" class="form-control" required>
                    <option value="1" th:selected="${voucher.trangThai == 1}">Đang Diễn Ra</option>
                    <option value="0" th:selected="${voucher.trangThai == 0}">Đã Kết Thúc</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="/voucher/hien-thi" class="btn btn-secondary">Quay Lại

        </a>
    </form>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
