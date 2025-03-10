package com.example.demo.controller.online;

import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
import com.example.demo.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class ForgotPasswordController {

    @Autowired
    private KhachHangRepository khachHangRepository;


    private final EmailService emailService;

    public ForgotPasswordController(EmailService emailService) {
        this.emailService = emailService;
    }


    @GetMapping("/forgot-password")
    public String forgotPassword() {
        return "online/login/forgot-password";
    }

    @GetMapping("/send-email")
    @ResponseBody
    public ResponseEntity<?> sendEmail(@RequestParam("email") String email, @RequestParam("username") String username) {
        List<KhachHang> khachHangs = khachHangRepository.findAll();
        boolean check = false;
        for (KhachHang kh : khachHangs) {
            if (kh.getTenDangNhap().equals(username)) {
                if (kh.getEmail().equals(email)) {
                    check = true;
                }
            }
        }
        if (check) {
            emailService.sendResetPasswordEmail(email, username);
            return ResponseEntity.ok(Map.of("code", 100));
        } else {
            return ResponseEntity.ok(Map.of("code", 200));
        }
    }

    @GetMapping("/reset-password")
    public String resetPassword() {
        return "online/login/reset-password";
    }

    @PutMapping("/confirm/reset-password")
    @ResponseBody
    public ResponseEntity<?> confirmResetPassword(@RequestParam("username") String username, @RequestParam("password") String password) {
        khachHangRepository.updatePasswordByUsername(password, username);
        return ResponseEntity.ok(Map.of("code", 100));
    }
}
