package com.example.demo.config;

import com.example.demo.entity.KhachHang;
import com.example.demo.service.KhachHangService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class SecurityUtil {
    private final KhachHangService khachHangService;

    public SecurityUtil(KhachHangService khachHangService) {
        this.khachHangService = khachHangService;
    }

    public KhachHang getCurrentKhachHang() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        Object principal = authentication.getPrincipal();
        System.out.println("Principal class: " + principal.getClass().getName()); // Debug kiểu dữ liệu

        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            return khachHangService.findByTenDangNhap(userDetails.getUsername());
        } else if (principal instanceof String) {
            return khachHangService.findByTenDangNhap((String) principal);
        }
        return null;
    }
}