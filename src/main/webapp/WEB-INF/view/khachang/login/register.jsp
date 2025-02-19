<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">

    <style>
        body {
            background: linear-gradient(to bottom, #E3F2FD, #BBDEFB);
        }
        .register-container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            position: relative;
        }
        .form-group input, .form-group select {
            padding-right: 40px;
        }
        .form-group .icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: gray;
        }
        input:focus::placeholder {
            color: transparent;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
            text-align: left;
        }
    </style>
</head>
<body>

<section class="vh-100 d-flex justify-content-center align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="register-container text-center">
                    <h1 class="text-primary mb-4">Register</h1>

                    <%-- Hiển thị thông báo đăng ký thành công --%>
                    <c:if test="${not empty successMessage}">
                        <p class="text-success">${successMessage}</p>
                    </c:if>

                    <form action="/register" method="POST">
                        <div class="mb-3 form-group">
                            <input type="text" name="customerName" class="form-control" placeholder="Customer name" value="${param.customerName}" required>
                            <i class="bi bi-person icon"></i>
                            <p class="error-message">${errorTenKhachHang}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="text" name="username" class="form-control" placeholder="Username" value="${param.username}" required>
                            <i class="bi bi-person-circle icon"></i>
                            <p class="error-message">${errorTenDangNhap}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                            <i class="bi bi-lock icon"></i>
                            <p class="error-message">${errorPassword}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="tel" name="phoneNumber" class="form-control" placeholder="Phone Number" value="${param.phoneNumber}" required>
                            <i class="bi bi-telephone icon"></i>
                            <p class="error-message">${errorSoDienThoai}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="text" name="address" class="form-control" placeholder="Address" value="${param.address}" required>
                            <i class="bi bi-geo-alt icon"></i>
                            <p class="error-message">${errorDiaChi}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="email" name="email" class="form-control" placeholder="Email" value="${param.email}" required>
                            <i class="bi bi-envelope icon"></i>
                            <p class="error-message">${errorEmail}</p>
                        </div>

                        <div class="mb-3 form-group">
                            <select name="gender" class="form-select" required>
                                <option value="">Select Gender</option>
                                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                            <i class="bi bi-gender-ambiguous icon"></i>
                            <p class="error-message">${errorGioiTinh}</p>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Register</button>
                        <p class="mt-3">Already have an account? <a href="/login/user" class="text-primary">Login</a></p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
