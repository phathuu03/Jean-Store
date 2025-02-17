package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.regex.Pattern;

@Controller
public class LoginUserController {

    @Autowired
    private UserRepository userRepository; // Inject repository vào Controller

    private static final Pattern EMAIL_REGEX = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    @GetMapping("/login/user")
    public String viewUserLogin(HttpSession session) {
        session.invalidate(); // Xóa session cũ khi mở trang đăng nhập
        return "khachang/login/login-user";
    }

    @PostMapping("/login/user")
    public String loginUser(@RequestParam(required = false) String email,
                            @RequestParam(required = false) String password,
                            HttpSession session,
                            Model model) {

        boolean hasError = false;

        // Kiểm tra email trống
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("errorEmail", "⚠️ Email không được để trống!");
            hasError = true;
        } else if (!EMAIL_REGEX.matcher(email).matches()) { // Kiểm tra định dạng email
            model.addAttribute("errorEmail", "⚠️ Email không hợp lệ!");
            hasError = true;
        }

        // Kiểm tra password trống
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không được để trống!");
            hasError = true;
        }

        if (hasError) {
            return "khachang/login/login-user";
        }

        // Kiểm tra tài khoản trong database (sử dụng findByEmailIgnoreCase để không phân biệt hoa thường)
        User user = userRepository.findByEmailIgnoreCase(email.trim());
        if (user == null || !user.getPassword().equals(password.trim())) {
            model.addAttribute("loginError", "❌ Email hoặc mật khẩu không chính xác!");
            return "khachang/login/login-user";
        }

        // Đăng nhập thành công
        session.setAttribute("userRole", "USER");
        return "redirect:/index";
    }
}
