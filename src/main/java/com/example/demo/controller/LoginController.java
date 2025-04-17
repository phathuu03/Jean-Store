package com.example.demo.controller;

import com.example.demo.entity.NhanVien;
import com.example.demo.repository.NhanVienRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private NhanVienRepository nhanVienRepository;

    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    @GetMapping("/login")
    public String viewLogin(HttpSession session, Model model) {
        session.invalidate(); // Xóa toàn bộ session
        model.addAttribute("tenDangNhap", "");
        return "quanly/login/login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String tenDangNhap,
            @RequestParam String matKhau,
            HttpSession session,
            Model model) {

        boolean hasError = false;

        // Kiểm tra tên đăng nhập rỗng
        if (tenDangNhap.trim().isEmpty()) {
            model.addAttribute("errorUsername", "⚠️ Tên đăng nhập không được để trống!");
            hasError = true;
        }

        // Kiểm tra mật khẩu rỗng
        if (matKhau.trim().isEmpty()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không được để trống!");
            hasError = true;
        }

        if (hasError) {
            model.addAttribute("tenDangNhap", tenDangNhap);
            return "quanly/login/login";
        }

        // Kiểm tra Admin
        if (ADMIN_USERNAME.equals(tenDangNhap)) {
            if (ADMIN_PASSWORD.equals(matKhau)) {
                session.setAttribute("userRole", "ADMIN");
                session.setAttribute("userName", "Administrator");
                return "redirect:/index";
            } else {
                model.addAttribute("errorPassword", "⚠️ Mật khẩu không đúng!");
                model.addAttribute("tenDangNhap", tenDangNhap);
                return "quanly/login/login";
            }
        }

        // Kiểm tra nhân viên
        NhanVien nhanVien = nhanVienRepository.findByTenDangNhap(tenDangNhap);
        if (nhanVien != null) {
            if (nhanVien.getMatKhau().equals(matKhau)) {
                session.setAttribute("userRole", "EMPLOYEE");
                session.setAttribute("userName", nhanVien.getTenNhanVien());
                session.setAttribute("userPosition", nhanVien.getChucVu());
                return "redirect:/index";
            } else {
                model.addAttribute("errorPassword", "⚠️ Mật khẩu không đúng!");
                model.addAttribute("tenDangNhap", tenDangNhap);
                return "quanly/login/login";
            }
        }

        // Nếu không tìm thấy tài khoản
        model.addAttribute("errorUsername", "⚠️ Tên đăng nhập không tồn tại!");
        return "quanly/login/login";
    }


}