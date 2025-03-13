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
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Chi tiết Hóa Đơn</h2>

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

        <!-- Nút điều hướng -->
        <div class="mt-4 text-center">
            <a href="/api/quan-ly/hoa-don/view-hoa-don" class="btn btn-secondary">Quay lại danh sách</a>
        </div>
    </div>

    <!-- Bootstrap Tabs cho danh sách Chi Tiết Hóa Đơn -->
    <h4 class="text-center mt-4 text-info">Danh sách Chi Tiết Hóa Đơn</h4>


    <div class="mt-3">
        <!-- Tất cả Chi Tiết Hóa Đơn -->
        <div class="fade show active" id="all">
            <jsp:include page="table-hoa-don-chi-tiet.jsp" />
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
