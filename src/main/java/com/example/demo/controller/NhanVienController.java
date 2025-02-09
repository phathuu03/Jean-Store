package com.example.demo.controller;

import com.example.demo.repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NhanVienController {
    @Autowired
    private NhanVienRepository nhanVienRepository;

    @GetMapping("/nhan-vien/hien-thi")
    public String hienThiNhanVien(Model model) {
        model.addAttribute("list", nhanVienRepository.findAll());
        return "quanly/nhanvien/nhanvien";
    }
}
