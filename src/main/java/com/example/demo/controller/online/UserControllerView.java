package com.example.demo.controller.online;

import com.example.demo.config.SecurityUtil;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Map;

@Controller
public class UserControllerView {
    @Autowired
    private KhachHangRepository khachHangRepository;
    private final SecurityUtil securityUtil;

    public UserControllerView(SecurityUtil securityUtil) {
        this.securityUtil = securityUtil;
    }

    @GetMapping("/user/detail")
    public String userDetail(Model model) {
        KhachHang khachHang = securityUtil.getCurrentKhachHang();
        model.addAttribute("user", khachHangRepository.findById(khachHang.getId()).get());
        return "online/user/user-detail";
    }


}
