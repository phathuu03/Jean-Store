<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .margin-top{
            margin-top: 100px;
        }
    </style>
</head>
<body>


<header class="p-3 bg-dark text-white mb-5 fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/index">Jeans Store</a>
        </div>
    </nav>
</header>


<div class="container-fluid margin-top  ">
    <div class="row">
        <div class="col-md-2 bg-dark text-white p-3">
            <h3>Menu</h3>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link text-white" href="/register" target="contentFrame">Page fds1</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="page2.jsp" target="contentFrame">Page 2</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="page3.jsp" target="contentFrame">Page 3</a>
                </li>
            </ul>
        </div>
        <div class="col-md-10">
            <iframe name="contentFrame" src="home.jsp" style="width: 100%; height: 100vh; border: none;"></iframe>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>