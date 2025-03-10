<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html language="java">
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
    <div class="card mb-4">
        <div class="card-header text-dark d-flex justify-content-between align-items-center">
            <h4>Doanh thu theo năm</h4>
            <select id="yearSelect" class="form-select w-auto">
                <option value="2022">Năm 2022</option>
                <option value="2023">Năm 2023</option>
                <option value="2024">Năm 2024</option>
                <option value="2025" selected>Năm 2025</option>
            </select>
        </div>
        <div class="card-body"><div class="chart-container"><canvas id="chartYear"></canvas></div></div>
    </div>

    <!-- Doanh thu theo khoảng thời gian -->
    <div class="card">
        <div class="card-header text-dark d-flex justify-content-between align-items-center">
            <h4>Doanh thu theo khoảng thời gian</h4>
            <div class="d-flex gap-2 align-items-center">
                <input type="date" id="startDate" class="form-control">
                <input type="date" id="endDate" class="form-control">
            </div>
        </div>
        <div class="card-body"><div class="chart-container"><canvas id="chartRange"></canvas></div></div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const labelsThang = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

    function parseData(data) {
        try {
            let parsedData = JSON.parse(data.replace(/&quot;/g, '"'));
            return Array.isArray(parsedData[0]) ? parsedData[0] : parsedData;
        } catch (e) {
            console.error("Lỗi khi parse JSON:", e);
            return [];
        }
    }

    // Lấy dữ liệu từ Thymeleaf
    const doanhThuThang = parseData('[[${doanhThuThang}]]');
    const doanhThuThucTeThang = parseData('[[${doanhThuThucTeThang}]]');
    const phiShipThang = parseData('[[${phiShipThang}]]');

    const doanhThuNam = parseData('[[${doanhThuNam}]]');
    const doanhThuThucTeNam = parseData('[[${doanhThuThucTeNam}]]');
    const phiShipNam = parseData('[[${phiShipNam}]]');

    const doanhThuKhoang = parseData('[[${doanhThuKhoang}]]');
    const doanhThuThucTeKhoang = parseData('[[${doanhThuThucTeKhoang}]]');
    const phiShipKhoang = parseData('[[${phiShipKhoang}]]');

    console.log("Dữ liệu doanh thu tháng:", JSON.stringify(doanhThuThang, null, 2));
    console.log("Dữ liệu doanh thu thực tế tháng:", JSON.stringify(doanhThuThucTeThang, null, 2));
    console.log("Dữ liệu phí ship tháng:", JSON.stringify(phiShipThang, null, 2));


    function createChart(canvasId, labels, totalRevenue, actualRevenue, shippingFee, maxY) {
        const canvas = document.getElementById(canvasId);
        if (!canvas) {
            console.error(`Không tìm thấy canvas với id: ${canvasId}`);
            return;
        }
        const ctx = canvas.getContext('2d');
        if (!ctx) {
            console.error(`Không thể lấy context từ canvas: ${canvasId}`);
            return;
        }

        return new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Tổng Doanh Thu',
                        data: totalRevenue,
                        borderColor: 'green',
                        backgroundColor: 'rgba(0, 128, 0, 0.5)',
                        fill: true
                    },
                    {
                        label: 'Doanh Thu Thực Tế',
                        data: actualRevenue,
                        borderColor: 'blue',
                        backgroundColor: 'rgba(0, 0, 255, 0.5)',
                        fill: true
                    },
                    {
                        label: 'Phí Ship',
                        data: shippingFee,
                        borderColor: 'orange',
                        backgroundColor: 'rgba(255, 165, 0, 0.5)',
                        fill: true
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { position: 'top' } },
                scales: {
                    x: { title: { display: true, text: "" } },
                    y: {
                        title: { display: true, text: "" },
                        beginAtZero: true,
                        max: maxY,
                        ticks: { callback: value => value.toLocaleString('vi-VN') + " đ" }
                    }
                }
            }
        });
    }

    setTimeout(() => {
        createChart('chartMonth', labelsThang, doanhThuThang, doanhThuThucTeThang, phiShipThang, 4_000_000);
        createChart('chartYear', labelsThang, doanhThuNam, doanhThuThucTeNam, phiShipNam, 10_000_000);
        createChart('chartRange', labelsThang, doanhThuKhoang, doanhThuThucTeKhoang, phiShipKhoang, 15_000_000);
    }, 500);
});

</script>

</body>
</html>
