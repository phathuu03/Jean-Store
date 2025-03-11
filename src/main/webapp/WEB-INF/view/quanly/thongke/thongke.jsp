<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê doanh thu</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .chart-container {
            width: 100%;
            height: 400px;
        }
        .gradient-green { background: linear-gradient(to right, #006400, #90EE90); color: white; }
        .gradient-blue { background: linear-gradient(to right, #0000FF, #8080FF); color: white; }
        .gradient-orange { background: linear-gradient(to right, #FFA500, #FFD580); color: black; }
    </style>
</head>
<body>
<div class="container mt-4">
    <h1 class="text-info">Quản Lý Thống Kê </h1><br>
    <div class="row mb-4">
        <div class="col-md-3"><div class="card gradient-orange text-center p-4"><h3 id="soDonHang">${soDonHang}</h3><p>Số Đơn Hàng</p></div></div>
        <div class="col-md-3"><div class="card gradient-green text-center p-4"><h3 id="tongDoanhThu">${tongDoanhThu} đ</h3><p>Tổng Doanh Thu</p></div></div>
        <div class="col-md-3"><div class="card gradient-blue text-center p-4"><h3 id="doanhThuThucTe">${tongDoanhThuThucTe} đ</h3><p>Doanh Thu Thực Tế</p></div></div>
    </div>
    <!-- Doanh thu theo tháng -->
    <div class="card mb-4">
        <div class="card-header text-dark"><h4>Doanh thu theo tháng</h4></div>
        <div class="card-body"><div class="chart-container"><canvas id="chartMonth"></canvas></div></div>
    </div>
    <!-- Doanh thu theo năm -->
    <!-- Doanh thu theo năm -->
    <div class="card mb-4">
        <div class="card-header text-dark"><h4>Doanh thu theo năm</h4></div>
        <div class="card-body"><div class="chart-container"><canvas id="chartYear"></canvas></div></div>
    </div>
</div>


<script th:inline="javascript">
document.addEventListener("DOMContentLoaded", function () {
    const labelsThang = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

    var doanhThuThang = [[${doanhThuThang}]]?.flat(2) || [];

    // 🔥 Đảm bảo dữ liệu không bị null hoặc undefined
    doanhThuThang = doanhThuThang ? doanhThuThang.flat().map(Number) : [];

    // 🔥 Điền tự động 0 vào các tháng thiếu
    while (doanhThuThang.length < 12) {
        doanhThuThang.push(0);
    }

    var tongDoanhThu = doanhThuThang.reduce((a, b) => a + b, 0);
    var tongPhiShip = Number([[${tongPhiShip}]] || 0);
    var soDonHang = Number([[${soDonHang}]] || 1);

    // 🔥 Chỉ tính doanh thu thực tế cho tháng có doanh thu
    var doanhThuThucTeThang = doanhThuThang.map(tien => (tien > 0 ? tien - (tongPhiShip / soDonHang) : 0));

    // 🔥 Phí ship cho từng tháng chỉ áp dụng khi có doanh thu
    var phiShipThang = [[${phiShipThang}]]?.flat(2).map(Number) || [];

    var maxYThang = Math.max(...doanhThuThang, ...doanhThuThucTeThang, ...phiShipThang, 1_000_000) * 1.2;

    console.log("🚀 doanhThuThang:", doanhThuThang);
    console.log("✅ maxYThang:", maxYThang);
    console.log("🚀 Phí ship từ Thymeleaf:", [[${phiShipThang}]]);

    function createChart(canvasId, labels, totalRevenue, actualRevenue, shippingFee, maxY) {
        const canvas = document.getElementById(canvasId);
        if (!canvas) return;

        if (Chart.getChart(canvasId)) {
            Chart.getChart(canvasId).destroy();
        }

        const ctx = canvas.getContext('2d');
        return new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    { label: 'Tổng Doanh Thu', data: totalRevenue, borderColor: 'green', borderDash: [5, 5], fill: false },
                    { label: 'Doanh Thu Thực Tế', data: actualRevenue, borderColor: 'blue', borderDash: [5, 5], fill: false },
                    { label: 'Phí Ship', data: shippingFee, borderColor: 'orange', borderDash: [5, 5], fill: false }
                ]

            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { position: 'top' } },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: maxY,
                        ticks: { callback: value => value.toLocaleString('vi-VN') + " đ" }
                    }
                }
            }
        });
    }

    createChart('chartMonth', labelsThang, doanhThuThang, doanhThuThucTeThang, phiShipThang, maxYThang);
});
</script>


<script th:inline="javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const labelsNam = ["2023", "2024", "2025"];

        // Kiểm tra và debug dữ liệu từ Thymeleaf
        var doanhThuNam = [[${doanhThuNam}]]?.flat(2) || [];
        console.log("📊 Dữ liệu doanh thu năm từ Thymeleaf:", doanhThuNam);

        // Chuyển đổi dữ liệu sang số nguyên
        doanhThuNam = doanhThuNam ? doanhThuNam.flat().map(Number) : [];

        // Đảm bảo đủ 3 năm dữ liệu
        while (doanhThuNam.length < labelsNam.length) {
            doanhThuNam.push(0);
        }

        console.log("✅ Dữ liệu doanh thu sau khi xử lý:", doanhThuNam);

        // Xác định giá trị trục Y tối đa
        var maxYNam = Math.max(...doanhThuNam, 5_000_000) * 1.2;

        function createGroupedBarChart(canvasId, labels, data) {
            const canvas = document.getElementById(canvasId);
            if (!canvas) {
                console.error("❌ Không tìm thấy thẻ <canvas> với ID:", canvasId);
                return;
            }

            // Hủy biểu đồ cũ nếu đã có
            if (Chart.getChart(canvasId)) {
                Chart.getChart(canvasId).destroy();
            }

            const ctx = canvas.getContext('2d');
            const chart = new Chart(ctx, {
                type: 'bar', // Biểu đồ cột nhóm
                data: {
                    labels: ["Doanh thu"], // Một nhóm duy nhất
                    datasets: [
                        {
                            label: "Năm 2023",
                            data: [doanhThuNam[0]],
                            backgroundColor: 'rgba(54, 162, 235, 0.7)', // Xanh
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        },
                        {
                            label: "Năm 2024",
                            data: [doanhThuNam[1]],
                            backgroundColor: 'rgba(255, 159, 64, 0.7)', // Cam
                            borderColor: 'rgba(255, 159, 64, 1)',
                            borderWidth: 1
                        },
                        {
                            label: "Năm 2025",
                            data: [doanhThuNam[2]],
                            backgroundColor: 'rgba(75, 192, 192, 0.7)', // Xanh lá
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { position: 'top' } },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: maxYNam,
                            ticks: { callback: value => value.toLocaleString('vi-VN') + " đ" }
                        }
                    }
                }
            });

            console.log("✅ Biểu đồ doanh thu theo năm đã được tạo:", chart);
        }

        createGroupedBarChart('chartYear', labelsNam, doanhThuNam);
    });
</script>

</body>
</html>
