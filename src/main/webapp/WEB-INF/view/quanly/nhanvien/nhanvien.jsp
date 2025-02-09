<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
        <style>
            /* Table Styling */
            table {
                width: 100%;
                border-collapse: collapse;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: center;
            }

            th {
                background-color: #f4f4f4;
            }

            /* Hover Effect for Rows */
            tbody tr:hover {
                background-color: #f0f8ff;
                cursor: pointer;
            }

            /* Form Styling */
            form {
                margin-bottom: 20px;
            }

            /* Button Styling */
            a.btn {
                padding: 8px 15px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                display: inline-block;
            }

            a.btn:hover {
                background-color: #0056b3;
            }
        </style>

</head>
<body>
<form action="" method=">
    <h1 style="color: blue;">Quản Lý Nhân Viên</h1>
    <table border="1" cellspacing="0" cellpadding="10" style="width: 50%; border-collapse: collapse;">
        <tr>
            <td>
                <div style="display: flex; align-items: center; margin-bottom: 15px;">
                    <label for="tenNhanVien" style="width: 20%;">Tên Nhân Viên:</label>
                    <input type="text" id="tenNhanVien" name="tenNhanVien" placeholder="Nhập tên nhân viên" style="width: 70%;">
                </div>

                <div style="display: flex; align-items: center; margin-bottom: 15px;">
                    <label for="tenDangNhap" style="width: 20%;">Tên Đăng Nhập:</label>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" placeholder="Nhập tên đăng nhập" style="width: 70%;">
                </div>

                <div style="display: flex; align-items: center; margin-bottom: 15px;">
                    <label for="matKhau" style="width: 20%;">Mật Khẩu:</label>
                    <input type="password" id="matKhau" name="matKhau" placeholder="Nhập mật khẩu" style="width: 70%;">
                </div>

                <div style="display: flex; align-items: center;">
                    <label for="soDienThoai" style="width: 20%;">Số Điện Thoại:</label>
                    <input type="text" id="soDienThoai" name="soDienThoai" placeholder="Nhập số điện thoại" style="width: 70%;">
                </div>
            </td>
        </tr>
    </table>
</form>

    <div>
        <input name="ten" placeholder="Nhập tên" style="padding: 5px;"/>
        <button type="submit" style="padding: 5px 10px;">Search</button>
    </div>
    <br>
    <div>
        <button style="background-color: #007bff; color: white; border: none; padding: 5px 10px; border-radius: 4px;">
            <a href="#" style="text-decoration: none; color: white;">Add</a>
        </button>
    </div>
<br>

<table>
    <thead>
    <tr>
        <th>Tên Nhân Viên</th>
        <th>Tên Đăng Nhập</th>
        <th>Mật Khẩu</th>
        <th>Số Điện Thoại</th>
        <th>Địa Chỉ</th>
        <th>Email</th>
        <th>Giới Tính</th>
        <th>Chức Vụ</th>
        <th>Ngày Tạo</th>
        <th>Ngày Sửa</th>
        <th>Trạng Thái</th>
        <th colspan="2">Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="sv" varStatus="stt">
        <tr>
            <td>${sv.tenNhanVien}</td>
            <td>${sv.tenDangNhap}</td>
            <td>${sv.matKhau}</td>
            <td>${sv.soDienThoai}</td>
            <td>${sv.diaChi}</td>
            <td>${sv.email}</td>
            <td>${sv.gioiTinh}</td>
            <td>${sv.chucVu}</td>
            <td>${sv.ngayTao}</td>
            <td>${sv.ngaySua}</td>
            <td>${sv.trangThai}</td>
            <td>
                <button><a href="">Detail</a></button>
                <button><a href="">Update</a></button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>