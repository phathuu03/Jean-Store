<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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

    <form th:action="@{/voucher/search}" method="get" id="searchForm" class="mb-4">
        <div class="row mb-3">
            <div class="col-md-6">
            <input type="text" id="searchInput" name="keyword" class="form-control"
                   th:value="${keyword}" placeholder="Tìm phiếu giảm giá">
            </div>
            <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> Tìm kiếm
                    </button>
            </div>
        </div>
    </form>

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
            <th>Giảm Giá Tối Đa</th>
            <th>Ngày Bắt Đầu</th>
            <th>Ngày kết thúc</th>
            <th>Trạng thái</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty listVoucher}">
                    <c:forEach items="${listVoucher}" var="voucher" varStatus="stt">
                        <tr>
                            <td>${(currentPage * size) + stt.index + 1}</td>
                            <td>${voucher.tenVoucher}</td>
                            <td>${voucher.moTa}</td>
                            <td>${voucher.soLuong}</td>
                            <td>${voucher.phanTramGiamGia}%</td>
                            <td>${voucher.dieuKienApDung}</td>
                            <td>${voucher.giamGiaToiDa}</td>
                            <td>${voucher.ngayBatDau}</td>
                            <td>${voucher.ngayKetThuc}</td>
                            <td>${voucher.trangThai == 1 ? "Đang Diễn Ra" : "Đã Kết Thúc"}</td>
                            <td>
                                <div style="display: flex; gap: 10px;">
                                    <a href="/voucher/detail/${voucher.id}" class="d-flex justify-content-center align-items-center p-2">
                                        <i class="bi bi-eye-fill fs-5"></i>
                                    </a>
                                    <a href="/voucher/view-update/${voucher.id}" class="btn btn-secondary">Update</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <tr>
                        <td colspan="11" class="text-center text-danger">Không tìm thấy voucher nào phù hợp!</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>


    </table>

    <div class="d-flex justify-content-between align-items-center mt-3">
        <!-- Nút phân trang -->
        <nav>
            <ul class="pagination">
                <c:if test="${currentPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage - 1}&size=${size}">&laquo; </a>
                    </li>
                </c:if>

                <!-- Danh sách trang -->
                <c:choose>
                    <c:when test="${totalPages > 0}">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&size=${size}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled">
                            <a class="page-link">1</a>
                        </li>
                    </c:otherwise>
                </c:choose>


                <c:if test="${currentPage < totalPages - 1}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage + 1}&size=${size}"> &raquo;</a>
                    </li>
                </c:if>
            </ul>
        </nav>

    </div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const pageSizeSelect = document.getElementById("pageSize");
        const rows = document.querySelectorAll("#voucherTable tbody tr"); // Lấy đúng tbody tránh lỗi

        function updateTable() {
            const pageSize = parseInt(pageSizeSelect.value, 10);

            if (rows.length === 0) {
                console.warn("Không có voucher nào để hiển thị.");
                return; // Tránh lỗi khi không có dữ liệu
            }

            // Hiển thị đúng số lượng voucher
            rows.forEach((row, index) => {
                row.style.display = index < pageSize ? "table-row" : "none";
            });
        }

        // Set giá trị mặc định là 6 dòng khi tải trang
        pageSizeSelect.value = "6";
        updateTable();

        // Lắng nghe thay đổi dropdown số lượng hiển thị
        pageSizeSelect.addEventListener("change", updateTable);
    });

</script>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
