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
<form action="" method="post">
    <table border="1" cellspacing="0" cellpadding="10" style="width: 100%; border-collapse: collapse; border-radius: 8px;">
        <h1 style="color: blue;">Quản Lý Nhân Vien</h1>

        <tr>
            <td style="vertical-align: top; width: 50%;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="tenNhanVien" style="width: 30%;">Tên Nhân Viên:</label>
                    <input type="text" id="tenNhanVien" name="tenNhanVien" placeholder="Nhập tên nhân viên" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="tenDangNhap" style="width: 30%;">Tên Đăng Nhập:</label>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" placeholder="Nhập tên đăng nhập" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="matKhau" style="width: 30%;">Mật Khẩu:</label>
                    <input type="password" id="matKhau" name="matKhau" placeholder="Nhập mật khẩu" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="soDienThoai" style="width: 30%;">Số Điện Thoại:</label>
                    <input type="text" id="soDienThoai" name="soDienThoai" placeholder="Nhập số điện thoại" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="diaChi" style="width: 30%;">Địa Chỉ:</label>
                    <input type="text" id="diaChi" name="diaChi" placeholder="Nhập địa chỉ" style="width: 65%;">
                </div>
            </td>

            <td style="vertical-align: top;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="email" style="width: 30%;">Email:</label>
                    <input type="email" id="email" name="email" placeholder="Nhập email" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="gioiTinh" style="width: 30%;">Giới Tính:</label>
                    <select id="gioiTinh" name="gioiTinh" style="width: 65%;">
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="chucVu" style="width: 30%;">Chức Vụ:</label>
                    <input type="text" id="chucVu" name="chucVu" placeholder="Nhập chức vụ" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="ngayTao" style="width: 30%;">Ngày Tạo:</label>
                    <input type="date" id="ngayTao" name="ngayTao" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="ngaySua" style="width: 30%;">Ngày Sửa:</label>
                    <input type="date" id="ngaySua" name="ngaySua" style="width: 65%;">
                </div>

                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <label for="trangThai" style="width: 30%;">Trạng Thái:</label>
                    <select id="trangThai" name="trangThai" style="width: 65%;">
                        <option value="Hoạt động">Hoạt động</option>
                        <option value="Ngừng hoạt động">Ngừng hoạt động</option>
                    </select>
                </div>
            </td>
        </tr>
    </table>
</form>




<table>
    <form action="" style="display: flex; justify-content: space-between; align-items: center;">
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
    </form>
<br>
<table>
    <form action="" >
        Tên: <input name="ten"/>
        <button type="submit">Search</button>
    </form>
    <br><br/>
    <button><a href="/nhan-vien/add">Add</a></button> <br><br/>
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