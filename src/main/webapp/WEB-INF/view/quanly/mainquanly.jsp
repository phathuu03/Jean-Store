<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            overflow-x: hidden; /* Ngăn chặn cuộn ngang */
        }
        .navbar {
            height: 56px; /* Điều chỉnh chiều cao nếu cần */
        }
        .margin-top {
            margin-top: 56px; /* Chiều cao của thanh navbar */
        }
        .sidebar {
            position: fixed;
            top: 70px; /* Dưới thanh điều hướng */
            bottom: 0;
            left: 0;
            z-index: 1000; /* Để trên cùng */
            padding: 20px 0;
            background-color: #bcc5cf; /* Màu nền cho sidebar */
            width: 250px; /* Chiều rộng của sidebar */
        }
        .main-content {
            margin-left: 250px; /* Rộng bằng với sidebar */
            padding: 20px;
        }
        .content-frame {
            width: 100%;
            height: calc(100vh - 56px); /* Điều chỉnh chiều cao theo chiều cao của navbar */
            border: none;
        }
    </style>
</head>
<body>


<header class="p-2 bg-dark text-white mb-5 fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/index">Jeans Store</a>
        </div>
    </nav>
</header>

<div class="container-fluid margin-top">
    <div class="row">
        <div class="col-md-2 bg-dark text-white p-3 sidebar">
            <h3>Quản lý</h3>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link text-white" href="/nhan-vien/hien-thi" target="contentFrame">Quản lý nhân viên</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="page2.jsp" target="contentFrame">Page 2</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="page3.jsp" target="contentFrame">Page 3</a>
                </li> <li class="nav-item">
                    <a class="nav-link text-white" href="/voucher/hien-thi" target="contentFrame">Voucher</a>
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
