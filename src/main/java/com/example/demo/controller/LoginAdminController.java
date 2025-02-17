package com.example.demo.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.regex.Pattern;

@Controller
public class LoginAdminController {

    private static final String ADMIN_EMAIL = "admin@jeans.com";
    private static final String ADMIN_PASSWORD = "admin123";

    // Regex kiểm tra email hợp lệ
    private static final Pattern EMAIL_REGEX = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    @GetMapping("/login/admin")
    public String viewAdminLogin(HttpSession session) {
        session.invalidate(); // Xóa session để tránh tự động chuyển hướng
        return "khachang/login/login-admin";
    }

    @PostMapping("/login/admin")
    public String loginAdmin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // Kiểm tra email không được để trống
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "⚠️ Email không được để trống!");
            return "khachang/login/login-admin";
        }

        // Kiểm tra định dạng email
        if (!EMAIL_REGEX.matcher(email).matches()) {
            model.addAttribute("error", "⚠️ Email không hợp lệ! Vui lòng nhập đúng định dạng.");
            return "khachang/login/login-admin";
        }

        // Kiểm tra mật khẩu không được để trống
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "⚠️ Mật khẩu không được để trống!");
            return "khachang/login/login-admin";
        }

        // Kiểm tra thông tin đăng nhập
        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("userRole", "ADMIN");
            return "redirect:/index";
        }

        // Trả về thông báo lỗi nếu sai
        model.addAttribute("error", "❌ Email hoặc mật khẩu admin không chính xác!");
        return "khachang/login/login-admin";
    }
}
