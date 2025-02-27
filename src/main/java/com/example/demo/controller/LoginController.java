package com.example.demo.controller;

import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
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

    private static final String ADMIN_EMAIL = "admin@jeans.com";
    private static final String ADMIN_PASSWORD = "admin123";

    // Regex kiểm tra email hợp lệ
    private static final Pattern EMAIL_REGEX = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@(?:gmail|yahoo|outlook|icloud|hotmail)\\.com$"
    );

    @GetMapping("/login")
    public String viewLogin(HttpSession session, Model model) {
        session.invalidate(); // Xóa session để tránh tự động chuyển hướng
        return "khachang/login/login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String password,
            HttpSession session,
            Model model) {

        boolean hasError = false;

        // Kiểm tra email
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("errorEmail", "⚠️ Email không được để trống!");
            hasError = true;
        } else if (!EMAIL_REGEX.matcher(email).matches()) {
            model.addAttribute("errorEmail", "⚠️ Email không hợp lệ!");
            hasError = true;
        }

        // Kiểm tra mật khẩu
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không được để trống!");
            hasError = true;
        }

        // Nếu có lỗi validate, giữ lại email đã nhập và hiển thị lại trang login
        if (hasError) {
            model.addAttribute("email", email);
            return "khachang/login/login";
        }

        // Kiểm tra đăng nhập cho Admin trước
        if (ADMIN_EMAIL.equals(email)) {
            if (ADMIN_PASSWORD.equals(password)) {
                session.setAttribute("userRole", "ADMIN");
                return "redirect:/index";
            } else {
                model.addAttribute("errorPassword", " Mật khẩu không chính xác!");
                model.addAttribute("email", email);
                return "khachang/login/login";
            }
        }

        // Tìm khách hàng theo email
        KhachHang khachHang = khachHangRepository.findByEmail(email);

        if (khachHang == null) {
            model.addAttribute("errorEmail", " Email không tồn tại!");
        } else if (!khachHang.getMatKhau().equals(password)) {
            model.addAttribute("errorPassword", " Mật khẩu không chính xác!");
        } else {
            // Đăng nhập thành công
            session.setAttribute("userRole", "USER");
            session.setAttribute("userName", khachHang.getTenKhachHang());
            return "redirect:/index";
        }

        // Giữ lại email đã nhập nếu có lỗi
        model.addAttribute("email", email);
        return "khachang/login/login";
    }


}
