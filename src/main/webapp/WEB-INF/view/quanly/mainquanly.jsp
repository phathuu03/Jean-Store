<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            overflow-x: hidden;
        }
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 1000;
            padding: 20px 0;
            background-color: #F0E6D2; /* Màu nhạt hơn */
            width: 250px;
            text-align: left;
        }
        .sidebar-logo img {
            width: 180px;
            height: auto;
            display: block;
            margin: 0 auto;
        }
        .main-title {
            font-size: 24px;
            font-weight: bold;
            color: #1F3A5F; /* Màu xanh đậm giống logo */
            margin-left: 20px;
        }
        .nav-link {
            color: #1F3A5F !important; /* Màu xanh đậm hơn */
            font-weight: bold;
            display: flex;
            align-items: center;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .nav-link i {
            margin-right: 10px;
        }
        .nav-link:hover {
            background-color: #d4c6a6;
        }
        .main-content {
            margin-left: 250px;
            padding: 40px 20px 20px;
        }
        .content-frame {
            width: 100%;
            height: calc(100vh - 50px);
            border: none;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 p-3 sidebar">
            <div class="sidebar-logo">
                <img src="https://file.hstatic.net/200000962346/file/snapbg.ai_1739957977396.png" alt="Jeans Store Logo">
            </div>
            <h3 class="main-title">Main</h3>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="/nhan-vien/hien-thi" target="contentFrame">
                        <i class="fas fa-user"></i> Quản lý nhân viên
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/api/quan-jean/quanjeans" target="contentFrame">
                        <i class="fas fa-tshirt"></i> Quản lý sản phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/api/quan-ly/quanly-thuoctinh" target="contentFrame">
                        <i class="fas fa-list"></i> Quản lý thuộc tính
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/voucher/hien-thi" target="contentFrame">
                        <i class="fas fa-ticket-alt"></i> Voucher
                    </a>
                </li>
            </ul>
        </div>
        <div class="col-md-10 main-content">
            <iframe name="contentFrame" src="/nhan-vien/hien-thi" class="content-frame"></iframe>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>