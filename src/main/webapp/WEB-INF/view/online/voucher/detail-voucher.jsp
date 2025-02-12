<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voucher Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-info mb-4">Chi Tiết Voucher</h2>

    <form>
        <div class="row g-4">
            <div class="col-md-6">
                <label for="tenVoucher" class="form-label">Tên Phiếu Giảm Giá</label>
                <input type="text" id="tenVoucher" name="tenVoucher" class="form-control" value="${voucher.tenVoucher}" readonly>
            </div>
            <div class="col-md-6">
                <label for="moTa" class="form-label">Mô Tả</label>
                <textarea id="moTa" name="moTa" class="form-control" rows="3" readonly>${voucher.moTa}</textarea>
            </div>

            <div class="col-md-6">
                <label for="soLuong" class="form-label">Số Lượng</label>
                <input type="number" id="soLuong" name="soLuong" class="form-control" value="${voucher.soLuong}" readonly>
            </div>
            <div class="col-md-6">
                <label for="phanTramGiamGia" class="form-label">Phần Trăm Giảm Giá</label>
                <input type="number" id="phanTramGiamGia" name="phanTramGiamGia" class="form-control" value="${voucher.phanTramGiamGia}" readonly>
            </div>

            <div class="col-md-6">
                <label for="dieuKien" class="form-label">Điều Kiện Áp Dụng</label>
                <input type="text" id="dieuKien" name="dieuKien" class="form-control" value="${voucher.dieuKienApDung}" readonly>
            </div>
            <div class="col-md-6">
                <label for="ngayBatDau" class="form-label">Ngày Bắt Đầu</label>
                <input type="date" id="ngayBatDau" name="ngayBatDau" class="form-control" value="${voucher.ngayBatDau}" readonly>
            </div>

            <div class="col-md-6">
                <label for="ngayKetThuc" class="form-label">Ngày Kết Thúc</label>
                <input type="date" id="ngayKetThuc" name="ngayKetThuc" class="form-control" value="${voucher.ngayKetThuc}" readonly>
            </div>

            <div class="col-md-6">
                <label for="trangThai" class="form-label">Trạng Thái</label>
                <input type="text" id="trangThai" name="trangThai" class="form-control"
                       value="${voucher.trangThai == 1 ? 'Kích Hoạt' : 'Ngừng Hoạt Động'}" readonly>
            </div>
        </div>

        <div class="mt-4">
            <a href="/voucher/hien-thi" class="btn btn-secondary">Quay Lại</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>