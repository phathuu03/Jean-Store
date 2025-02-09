
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
          <style>
              .page-title {
                  color: #007bff;
                  font-weight: bold;
                  margin-bottom: 20px;
              }

              .action-btns {
                  display: flex;
                  justify-content: flex-end;
                  gap: 10px;
              }

          </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="page-title">Quản Lý Voucher</h2>
    <div class="row mb-3">
        <div class="col-md-8">
            <input type="text" class="form-control" placeholder="Tìm phiếu giảm giá">
        </div>
        <div class="col-md-2">
            <input type="date" class="form-control">
        </div>
        <div class="col-md-2">
            <input type="date" class="form-control">
        </div>
    </div>

<div class="action-btns mb-3">
    <button class="btn btn-primary">Xuất Excel</button>
    <a href="/voucher/view-add" class="btn btn-success">+ Tạo Mới</a>
</div>


    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>Tên Voucher</th>
            <th>Mô Tả</th>
            <th>Số Lượng</th>
            <th>Phần Trăm Giảm Giá</th>
            <th>Điều Kiện Áp Dụng</th>
            <th>Ngày Bắt Đầu</th>
            <th>Ngày kết thúc</th>
            <th>Trạng thái</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listVoucher}" var="voucher" varStatus="stt">
            <tr>
                <td>${stt.index + 1}</td>
                <td>${voucher.tenVoucher}</td>
                <td>${voucher.moTa}</td>
                <td>${voucher.soLuong}</td>
                <td>${voucher.phanTramGiamGia}%</td>
                <td>${voucher.dieuKienApDung}</td>
                <td>${voucher.ngayBatDau}</td>
                <td>${voucher.ngayKetThuc}</td>
                <td>${voucher.trangThai == 0 ? "Hoat Dong":"Ngung Hoat Dong"}</td>

                <td>
                    <div style="display: flex; gap: 10px;">
                        <a href="detailVoucher?id=${voucher.id}" class="btn btn-warning">Detail</a>
                        <a href="updateVoucher?id=${voucher.id}" class="btn btn-secondary">Update</a>
                    </div>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>