<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết Hóa Đơn</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h2 {
            margin-top: 20px;
        }
        .process-bar-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
            z-index: 0;
        }
        .process-step {
            position: relative;
            width: 18%;
            text-align: center;
            font-weight: bold;
        }
        .process-step-text {
            font-size: 12px;
            margin-top: 5px;
        }
        .process-step-circle {
            width: 50px;
            height: 50px;
            background-color: #ddd;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            font-size: 20px;
            color: #333;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }
        .process-step.completed .process-step-circle {
            background-color: #28a745; /* Xanh lá */
            color: #fff;
            transform: scale(1.1);
        }
        .process-step.active .process-step-circle {
            background-color: #007bff; /* Xanh dương */
            color: #fff;
            transform: scale(1.1);
        }
        .process-step.inactive .process-step-circle {
            background-color: #ccc;
            color: #333;
        }
        .process-step.completed .process-step-text,
        .process-step.active .process-step-text {
            color: #000;
        }
        .process-step.inactive .process-step-text {
            color: #999;
        }
        .process-bar-container::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 4px;
            background-color: #ddd;
            z-index: -1;
        }
        .process-step.completed ~ .process-step::after {
            background-color: #28a745; /* Xanh lá */
        }
        .process-step.active ~ .process-step::after {
            background-color: #007bff; /* Xanh dương */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Chi tiết Hóa Đơn</h2>

    <!-- Hiển thị thông báo nếu trạng thái đơn hàng là 4 -->
    <c:if test="${hoaDon.publicTrangThai >= 4}">
        <div class="alert alert-danger text-center" role="alert">
            Đơn hàng đã bị hủy!
        </div>
    </c:if>

    <!-- Thanh trạng thái đơn hàng chỉ hiển thị nếu trạng thái < 4 -->
    <c:if test="${hoaDon.publicTrangThai < 4}">
        <div class="process-bar-container">
            <!-- Trạng thái "Chờ xác nhận" sẽ có class 'active' nếu trang thái là 0 -->
            <div class="process-step ${hoaDon.publicTrangThai == 0 ? 'active' : hoaDon.publicTrangThai > 0 ? 'completed' : 'inactive'}">
                <div class="process-step-circle">1</div>
                <div class="process-step-text">Chờ xác nhận</div>
            </div>

            <div class="process-step ${hoaDon.publicTrangThai >= 2 ? 'completed' : hoaDon.publicTrangThai == 1 ? 'active' : 'inactive'}">
                <div class="process-step-circle">2</div>
                <div class="process-step-text">Chờ giao hàng</div>
            </div>

            <div class="process-step ${hoaDon.publicTrangThai >= 3 ? 'completed' : hoaDon.publicTrangThai == 2 ? 'active' : 'inactive'}">
                <div class="process-step-circle">3</div>
                <div class="process-step-text">Đang giao hàng</div>
            </div>

            <div class="process-step ${hoaDon.publicTrangThai >= 3 ? 'completed' : hoaDon.publicTrangThai == 3 ? 'active' : 'inactive'}">
                <div class="process-step-circle">4</div>
                <div class="process-step-text">Đã nhận hàng</div>
            </div>

            <div class="process-step ${hoaDon.publicTrangThai >= 4 ? 'completed' : hoaDon.publicTrangThai == 3 ? 'active' : 'inactive'}">
                <div class="process-step-circle">5</div>
                <div class="process-step-text">Đã thanh toán</div>
            </div>
        </div>
    </c:if>


    <c:if test="${hoaDon.publicTrangThai == 0}">
        <div class="text-center mt-4 mb-4">
            <form action="/xac-nhan-don-hang" method="POST">
                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                <button type="submit" class="btn-confirm">Xác nhận đơn hàng</button>
            </form>
        </div>
    </c:if>
</div>


    <!-- Card chứa thông tin hóa đơn -->
    <div class="card shadow-lg p-4">
        <div class="row">
            <!-- Cột trái: Thông tin Hóa Đơn -->
            <div class="col-md-6">
                <h4 class="text-primary">Thông tin Hóa Đơn</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>ID: </strong> ${hoaDon.id}</li>
                    <li class="list-group-item"><strong>Mã hóa đơn: </strong> ${hoaDon.maHoaDon}</li>
                    <li class="list-group-item">
                        <strong>Tổng Tiền: </strong>
                        <fmt:formatNumber value="${hoaDon.tongTien}" type="currency" currencySymbol="₫" groupingUsed="true" />
                    </li>
                    <li class="list-group-item">
                        <strong>Tiền ship: </strong>
                        <fmt:formatNumber value="${hoaDon.phiShip}" type="currency" currencySymbol="₫" groupingUsed="true" />
                    </li>
                    <li class="list-group-item">
                        <strong>Giảm giá: </strong>
                        <c:choose>
                            <c:when test="${not empty hoaDon.giamGia}">
                                <fmt:formatNumber value="${hoaDon.giamGia}" type="currency" currencySymbol="₫" groupingUsed="true" />
                            </c:when>
                            <c:otherwise>
                                0 ₫
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item">
                        <strong>Thành tiền: </strong>
                        <fmt:formatNumber value="${hoaDon.thanhTien}" type="currency" currencySymbol="₫" groupingUsed="true" />
                    </li>
                    <li class="list-group-item"><strong>Voucher: </strong>
                        <c:choose>
                            <c:when test="${hoaDon.voucher != null}">
                                ${hoaDon.voucher.tenVoucher}
                            </c:when>
                            <c:otherwise>
                                Không dùng voucher
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Trạng Thái:</strong> ${hoaDon.trangThai}</li>
                </ul>
            </div>

            <!-- Cột phải: Thông tin bổ sung -->
            <div class="col-md-6">
                <h4 class="text-success">Thông tin bổ sung</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Khách Hàng:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.khachHang != null}">
                                ${hoaDon.khachHang.tenKhachHang}
                            </c:when>
                            <c:otherwise>
                                Không có thông tin khách hàng
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Nhân Viên:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.nhanVien != null}">
                                ${hoaDon.nhanVien.tenNhanVien}
                            </c:when>
                            <c:otherwise>
                                Không có thông tin nhân viên
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Phương Thức Thanh Toán:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.pttt != null}">
                                ${hoaDon.pttt.tenPTTT}
                            </c:when>
                            <c:otherwise>
                                Không có thông tin PTTT
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Địa Chỉ Giao Hàng:</strong> ${hoaDon.diaChiGiaoHang}</li>
                    <li class="list-group-item"><strong>Ngày Thanh Toán:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.ngayThanhToan != null}">
                                <fmt:formatDate value="${hoaDon.ngayThanhToan}" pattern="dd/MM/yyyy" />
                            </c:when>
                            <c:otherwise>
                                Chưa thanh toán
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Ngày Tạo:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.ngayTao != null}">
                                <fmt:formatDate value="${hoaDon.ngayTao}" pattern="dd/MM/yyyy" />
                            </c:when>
                            <c:otherwise>
                                Không có ngày tạo
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Ngày Sửa:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.ngaySua != null}">
                                <fmt:formatDate value="${hoaDon.ngaySua}" pattern="dd/MM/yyyy" />
                            </c:when>
                            <c:otherwise>
                                Chưa cập nhật
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Hiển thị sản phẩm trong hóa đơn -->
        <h4 class="text-success mt-5">Sản phẩm trong đơn hàng</h4>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Stt</th>
                <th scope="col">Mã sản phẩm</th>
                <th scope="col">Tên Sản Phẩm</th>
                <th scope="col">Số Lượng</th>
                <th scope="col">Đơn Giá</th>
                <th scope="col">Thành Tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="hdct" items="${listHdct}" varStatus="item">
                <c:if test="${empty param.filter || hdct.trangThai == param.filter}">
                    <tr>
                        <td>${item.index + 1}</td>
                        <td>${hdct.quanJeansChiTiet.quanJeans.maSanPham}</td>
                        <td>${hdct.quanJeansChiTiet.quanJeans.tenSanPham}</td>
                        <td>${hdct.soLuong}</td>
                        <td>${hdct.donGia}</td>
                        <td>${hdct.tongTien}</td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <!-- Nút điều hướng -->
        <div class="mt-4 text-center">
            <a href="javascript:window.history.back()" class="btn btn-secondary me-2">Quay lại danh sách</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
