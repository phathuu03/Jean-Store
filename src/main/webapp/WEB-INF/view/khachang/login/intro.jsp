
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Jeans-Store</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://code.angularjs.org/1.8.2/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.8.2/angular-route.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body style="background-color: aliceblue">
<header class="p-3 bg-dark text-white">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark ">
        <div class="container-fluid">
            <a class="navbar-brand" href="/intro">Jeans Store</a>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a href="/login" class="btn btn-outline-light me-2">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-warning" href="/register">Sign-up</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

</header>
<div class="banner">
    <img src="${pageContext.request.contextPath}/image/bannerJeans.png" class="img-fluid w-100 h-90" style="margin-top: 20px;">
</div>
<div ng-app="myApp" class="content" style="margin-top: 50px;margin-left: 100px">
    <div class="container" style="margin: 40px;">

    </div>

    <div class="container">
        <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
            <div class="col-md-4 d-flex align-items-center">
                <a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                    <svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
                </a>
                <span class="text-muted">© 2025 Company, Jeans Store</span>
            </div>

            <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">

            </ul>
        </footer>
    </div>
</div>
</body>
</html>
