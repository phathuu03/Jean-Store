package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class LogoutController {

    @GetMapping("/admin/logout")
    public String logout() {
        // Xóa session
        
        // Chuyển hướng về trang đăng nhập
        return "redirect:/login";
    }
}
