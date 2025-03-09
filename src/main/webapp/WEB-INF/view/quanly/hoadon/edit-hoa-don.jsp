<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh Sửa Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="card shadow-lg p-4">
        <form action="/api/quan-ly/hoa-don/update/hoa-don" method="post">
            <!-- ID hóa đơn ẩn -->
            <input type="hidden" name="id" value="${hoaDon.id}" />

            <div class="row">
                <!-- Cột trái: Thông tin Hóa Đơn -->
                <div class="col-md-6">
                    <h4 class="text-primary">Thông tin Hóa Đơn</h4>
                    <div class="mb-3">
                        <label for="tongTien" class="form-label"><strong>Tổng Tiền:</strong></label>
                        <input type="number" step="0.01" class="form-control" id="tongTien" name="tongTien" value="${hoaDon.tongTien}" required>
                    </div>
                    <div class="mb-3">
                        <label for="diaChiGiaoHang" class="form-label"><strong>Địa Chỉ Giao Hàng:</strong></label>
                        <input type="text" class="form-control" id="diaChiGiaoHang" name="diaChiGiaoHang" value="${hoaDon.diaChiGiaoHang}" required>
                    </div>
                    <div class="mb-3">
                        <label for="ngayThanhToan" class="form-label"><strong>Ngày Thanh Toán:</strong></label>
                        <input type="date" class="form-control" id="ngayThanhToan" name="ngayThanhToan"
                               value="<c:if test='${hoaDon.ngayThanhToan != null}'><fmt:formatDate value='${hoaDon.ngayThanhToan}' pattern='yyyy-MM-dd'/></c:if>">
                    </div>

                    <div class="mb-3">
                        <label for="trangThai" class="form-label"><strong>Trạng Thái:</strong></label>
                        <select class="form-select" id="trangThai" name="trangThai">
                            <option value="0" <c:if test="${hoaDon.trangThai == 0}">selected</c:if>>Chưa Thanh Toán</option>
                            <option value="1" <c:if test="${hoaDon.trangThai == 1}">selected</c:if>>Đã Thanh Toán</option>
                        </select>
                    </div>
                </div>

                <!-- Cột phải: Thông tin bổ sung -->
                <div class="col-md-6">
                    <h4 class="text-success">Thông tin bổ sung</h4>
                    <div class="mb-3">
                        <label for="khachHang" class="form-label"><strong>Khách Hàng:</strong></label>
                        <select class="form-select" id="khachHang" name="khachHang">
                            <option value="">-- Chọn Khách Hàng --</option>
                            <c:forEach items="${dsKhachHang}" var="kh">
                                <option value="${kh.id}" <c:if test="${hoaDon.khachHang != null and hoaDon.khachHang.id == kh.id}">selected</c:if>>
                                        ${kh.tenKhachHang}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="nhanVien" class="form-label"><strong>Nhân Viên:</strong></label>
                        <select class="form-select" id="nhanVien" name="nhanVien">
                            <option value="">-- Chọn Nhân Viên --</option>
                            <c:forEach items="${dsNhanVien}" var="nv">
                                <option value="${nv.id}" <c:if test="${hoaDon.nhanVien != null and hoaDon.nhanVien.id == nv.id}">selected</c:if>>
                                        ${nv.tenNhanVien}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="voucher" class="form-label"><strong>Voucher:</strong></label>
                        <select class="form-select" id="voucher" name="voucher">
                            <option value="">-- Chọn Voucher --</option>
                            <c:forEach items="${dsVoucher}" var="vc">
                                <option value="${vc.id}" <c:if test="${hoaDon.voucher != null and hoaDon.voucher.id == vc.id}">selected</c:if>>
                                        ${vc.tenVoucher}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="pttt" class="form-label"><strong>Phương Thức Thanh Toán:</strong></label>
                        <select class="form-select" id="pttt" name="pttt">
                            <option value="">-- Chọn PTTT --</option>
                            <c:forEach items="${dsPttt}" var="pt">
                                <option value="${pt.id}" <c:if test="${hoaDon.pttt != null and hoaDon.pttt.id == pt.id}">selected</c:if>>
                                        ${pt.tenPTTT}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Nút điều hướng -->
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-warning me-2">Lưu Thay Đổi</button>
                <a href="javascript:window.history.back()" class="btn btn-secondary me-2">
                    Quay lại
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
