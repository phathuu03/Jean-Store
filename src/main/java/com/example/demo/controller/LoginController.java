package com.example.demo.controller;

import com.example.demo.entity.KhachHang;
import com.example.demo.entity.NhanVien;
import com.example.demo.repository.KhachHangRepository;
import com.example.demo.repository.NhanVienRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.regex.Pattern;

@Controller
public class LoginController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private NhanVienRepository nhanVienRepository;

    private static final String ADMIN_EMAIL = "admin@gmail.com";
    private static final String ADMIN_PASSWORD = "admin123";

    private static final Pattern EMAIL_REGEX = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    @GetMapping("/login")
    public String viewLogin(HttpSession session, Model model) {
        session.invalidate(); // Xóa toàn bộ session
        model.addAttribute("email", ""); // Đảm bảo không hiển thị lại email
        return "khachang/login/login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String password,
            HttpSession session,
            Model model) {

        boolean hasError = false;

        // Kiểm tra email rỗng hoặc không hợp lệ
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("errorEmail", "⚠️ Email không được để trống!");
            hasError = true;
        } else if (!EMAIL_REGEX.matcher(email).matches()) {
            model.addAttribute("errorEmail", "⚠️ Email không hợp lệ!");
            hasError = true;
        }

        // Kiểm tra mật khẩu rỗng
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không được để trống!");
            hasError = true;
        }

        if (hasError) {
            model.addAttribute("email", email);
            return "khachang/login/login";
        }

        // 🚫 Chặn khách hàng ngay từ đầu
        KhachHang khachHang = khachHangRepository.findByEmail(email);
        if (khachHang != null) {
            model.addAttribute("errorEmail", "⚠️ Tài khoản khách hàng không được phép đăng nhập!");
            return "khachang/login/login";
        }

        // ✅ Kiểm tra Admin
        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("userRole", "ADMIN");
            session.setAttribute("userName", "Admin");
            return "redirect:/index";
        } else if (ADMIN_EMAIL.equals(email)) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không đúng!");
            model.addAttribute("email", email);
            return "khachang/login/login";
        }

        // ✅ Kiểm tra nhân viên
        NhanVien nhanVien = nhanVienRepository.findByEmail(email);
        if (nhanVien != null && nhanVien.getMatKhau().equals(password)) {
            session.setAttribute("userRole", "EMPLOYEE");
            session.setAttribute("userName", nhanVien.getTenNhanVien());
            session.setAttribute("userPosition", nhanVien.getChucVu());
            return "redirect:/index";
        } else if (nhanVien != null) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không đúng!");
            model.addAttribute("email", email);
            return "khachang/login/login";
        }

        // ✅ Nếu email không tồn tại
        model.addAttribute("errorEmail", "⚠️ Email không tồn tại!");
        return "khachang/login/login";
    }

}
