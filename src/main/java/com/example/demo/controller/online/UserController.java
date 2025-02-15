package com.example.demo.controller.online;

import com.example.demo.config.SecurityUtil;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private KhachHangRepository khachHangRepository;

    private final SecurityUtil securityUtil;

    public UserController(SecurityUtil securityUtil) {
        this.securityUtil = securityUtil;
    }

    @GetMapping("/id")
    public ResponseEntity<?> getCurrentUserId() {
        KhachHang khachHang = securityUtil.getCurrentKhachHang();
        return ResponseEntity.ok(Map.of("id",khachHang.getId()));
    }
    @GetMapping("")
    public ResponseEntity<?> getUserById(@RequestParam("id") Long id) {
        return ResponseEntity.ok(Map.of("khachHang",khachHangRepository.getKhachHangById(id)));
    }
}