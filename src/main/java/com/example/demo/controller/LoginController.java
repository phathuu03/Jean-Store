package com.example.demo.controller;

import com.example.demo.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    private final User admin = new User("admin@gmail.com", "admin123", "admin");
    private final User user = new User("user@gmail.com", "user123", "user");

    @GetMapping("/login")
    public String viewLogin() {
        return "online/login/login";
    }

    @PostMapping("/login")
    public String handleLogin(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String role,
            Model model
    ) {
        // Nếu user cố tình đăng nhập với vai trò admin
        if ("admin".equalsIgnoreCase(role) && !email.equals(admin.getEmail())) {
            model.addAttribute("error", "Bạn không có quyền đăng nhập với vai trò Admin!");
            return "online/login/login";
        }

        // Kiểm tra thông tin đăng nhập
        if (isValidUser(email, password, role)) {
            if ("admin".equals(role)) {
                return "redirect:/admin";
            } else {
                return "redirect:/user/home";
            }
        } else {
            model.addAttribute("error", "Invalid email, password, or role!");
            return "online/login/login";
        }
    }

    private boolean isValidUser(String email, String password, String role) {
        if ("admin".equals(role)) {
            return admin.getEmail().equals(email) && admin.getPassword().equals(password);
        } else if ("user".equals(role)) {
            return user.getEmail().equals(email) && user.getPassword().equals(password);
        }
        return false;
    }
}
