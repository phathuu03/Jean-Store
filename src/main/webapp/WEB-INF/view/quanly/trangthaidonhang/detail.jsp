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

    <!-- Hiển thị thông báo lỗi nếu có -->
    <div id="errorMessages" class="alert alert-danger" style="display:none;"></div>

    <!-- Hiển thị thông báo nếu trạng thái đơn hàng là 4 -->
    <c:if test="${hoaDon.publicTrangThai >= 4}">
        <div class="alert alert-danger text-center" role="alert">
            Đơn hàng đã bị hủy!
        </div>
    </c:if>

    <!-- Thanh trạng thái đơn hàng chỉ hiển thị nếu trạng thái < 4 -->
    <c:if test="${hoaDon.publicTrangThai < 4}">
        <div class="process-bar-container">
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

    <!-- Hiển thị nút "Xác nhận đơn hàng" khi trạng thái là 0 -->
    <c:if test="${hoaDon.publicTrangThai == 0}">
        <div class="text-center mt-4 mb-4">
            <form action="javascript:void(0);" onsubmit="return confirmConfirm();">
                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                <button type="submit" class="btn btn-primary">Xác nhận đơn hàng</button>
            </form>
        </div>
    </c:if>

    <!-- Hiển thị nút "Sẵn sàng giao hàng" khi trạng thái là 1 -->
    <c:if test="${hoaDon.publicTrangThai == 1}">
        <div class="text-center mt-4 mb-4">
            <form action="/xac-nhan-vc-nhan-don-hang" method="POST">
                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                <button type="submit" class="btn btn-success">Sẵn sàng giao hàng</button>
            </form>
        </div>
    </c:if>

    <c:if test="${hoaDon.publicTrangThai == 2}">
        <div class="text-center mt-4 mb-4">
            <form action="/hoan-thanh-don-hang" method="POST">
                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                <button type="submit" class="btn btn-success">Hoàn thành đơn hàng</button>
            </form>
        </div>
    </c:if>

    <!-- Hiển thị nút "Hủy đơn hàng" khi trạng thái < 3 -->
    <c:if test="${hoaDon.publicTrangThai == 0}">
        <div class="text-center mt-4 mb-4">
            <form action="/huy-don-hang" method="POST" onsubmit="return confirmCancel();">
                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                <button type="submit" class="btn btn-danger">Hủy đơn hàng</button>
            </form>

            <script>
                function confirmCancel() {
                    return confirm("Bạn chắc chắn muốn hủy đơn hàng này?");
                }
            </script>
        </div>
    </c:if>

    <!-- Card chứa thông tin hóa đơn -->
    <div class="card shadow-lg p-4 mt-5">
        <div class="row">
            <div class="col-md-6">
                <h4 class="text-primary">Thông tin Hóa Đơn</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>ID: </strong> ${hoaDon.id}</li>
                    <li class="list-group-item"><strong>Mã hóa đơn: </strong> ${hoaDon.maHoaDon}</li>
                    <li class="list-group-item">
                        <strong>Tổng Tiền: </strong>
                        <fmt:formatNumber value="${hoaDon.tongTien}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </li>
                    <li class="list-group-item">
                        <strong>Tiền ship: </strong>
                        <fmt:formatNumber value="${hoaDon.phiShip}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </li>
                    <li class="list-group-item">
                        <strong>Giảm giá: </strong>
                        <c:choose>
                            <c:when test="${not empty hoaDon.giamGia}">
                                <fmt:formatNumber value="${hoaDon.giamGia}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                            </c:when>
                            <c:otherwise>
                                0 ₫
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item">
                        <strong>Thành tiền: </strong>
                        <fmt:formatNumber value="${hoaDon.thanhTien}" type="currency" currencySymbol="₫" groupingUsed="true"/>
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
                                <fmt:formatDate value="${hoaDon.ngayThanhToan}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>
                                Chưa thanh toán
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </div>
        </div>

        <div class="mt-4 text-center">
            <a href="javascript:window.history.back()" class="btn btn-secondary me-2">Quay lại danh sách</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function confirmConfirm() {
        var hoaDonId = ${hoaDon.id}; // Lấy ID hóa đơn từ JSP

        $.ajax({
            url: '/xac-nhan-don-hang',  // Đường dẫn tới @PostMapping của bạn
            type: 'POST',
            data: { hoaDonId: hoaDonId },  // Dữ liệu gửi đi (ID hóa đơn)
            success: function(response) {
                // Hiển thị thông báo thành công nếu không có lỗi
                alert(response); // Bạn có thể tùy chỉnh thông báo này
                location.reload(); // Tải lại trang sau khi xác nhận thành công (hoặc cập nhật phần tử nào đó nếu cần)
            },
            error: function(xhr, status, error) {
                // Hiển thị lỗi nếu có
                var errors = xhr.responseJSON;
                var errorMessage = errors.join("<br>"); // Chuyển danh sách lỗi thành chuỗi HTML
                $('#errorMessages').html(errorMessage).show(); // Hiển thị lỗi trong phần tử có id là errorMessages
            }
        });

        return false;  // Ngăn form gửi lại trang
    }
</script>

</body>
</html>
