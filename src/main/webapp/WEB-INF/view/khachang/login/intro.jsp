<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Jeans-Store</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">

<style>
    body {
        background-color: aliceblue;
    }
    .banner-container {
        position: relative;
        text-align: center;
        color: black;
    }
    .banner-container img {
        width: 100%;
        height: auto;
    }
    .banner-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        text-align: center;
        background-color: #2c3e50; /* Darker solid color */
        width: 50%;
        padding: 50px;
        border-radius: 30px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.25);
        color: white;
    }
    .btn-role {
        margin: 8px;
        font-size: 22px;
        padding: 14px 28px;
        border-radius: 14px;
        border: 2px solid #555;
    }
    .btn-outline-dark {
        background-color: rgba(255, 255, 255, 0.9);
        color: #333;
        border-color: #333;
    }

    .btn-outline-info {
        background-color: rgba(255, 255, 255, 0.9);
        color: #333;
        border-color: #333;
    }

    .btn-outline-info:hover {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }
</style>

</head>
<body>
<!-- Banner với form chọn vai trò -->
<div class="banner-container">
    <img src="https://file.hstatic.net/200000962346/file/banner_jeans_store.jpg"
         class="img-fluid">

    <!-- Form lớn với màu nền mới -->
    <div class="banner-text">
        <h1 class="fw-bold ">Welcome to Jeans Store</h1>
        <p class="fs-4">Who are you?</p>
        <div>
            <a href="/login/user" class="btn btn-outline-dark btn-role btn-sm">User</a>
            <a href="/login/admin" class="btn btn-outline-info btn-role btn-sm">Admin</a>
        </div>
    </div>
</div>

</body>
</html>
