package com.example.demo.controller;

import com.example.demo.entity.NhanVien;
import com.example.demo.repository.NhanVienRepository;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Controller
public class NhanVienController {
    @Autowired
    private NhanVienRepository nhanVienRepository;

    @GetMapping("/nhan-vien/hien-thi")
    public String hienThiNhanVien(Model model) {
        model.addAttribute("list", nhanVienRepository.findAll());
        return "quanly/nhanvien/nhanvien";
    }

    @GetMapping("/search")
    public String searchNhanVien(@RequestParam("query") String query, Model model) {
        List<NhanVien> ketQua = nhanVienRepository.findByTenNhanVienContaining(query);
        model.addAttribute("list", ketQua);
        return "quanly/nhanvien/nhanvien"; // Trang hiển thị kết quả
    }


    @GetMapping("/nhan-vien/detail/{id}")
    public String detail(@PathVariable("id") Long id, Model model) {
        model.addAttribute("nv", nhanVienRepository.findById(id).orElse(null));
        return "/quanlu/nhanvien/detail-nhanvien";
    }

    @GetMapping("/nhan-vien/view-add")
    public String viewAdd() {
        return "quanly/nhanvien/add-nhanvien";
    }

    @PostMapping("/nhan-vien/add")  // Đảm bảo đúng URL
    public String add(@ModelAttribute("nv") @Valid NhanVien nhanVien, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("errors", result.getAllErrors()); // Trả về lỗi để hiển thị
            return "quanly/nhanvien/add-nhanvien";
        }

        nhanVienRepository.save(nhanVien);
        return "redirect:/nhan-vien/hien-thi";
    }

    @GetMapping("/nhan-vien/view-update/{id}")
    public String viewUpdateNhanVien(@PathVariable("id") Long id, Model model) {
        Optional<NhanVien> optionalNhanVien = nhanVienRepository.findById(id);
        if (optionalNhanVien.isPresent()) {
            model.addAttribute("nv", optionalNhanVien.get());
            return "quanly/nhanvien/update-nhanvien";
        }
        return "redirect:/nhan-vien/hien-thi";
    }


    @PostMapping("/nhan-vien/update/{id}")
    public String updateNhanVien(@PathVariable("id") Long id, @ModelAttribute("nv") @Valid NhanVien nhanVien, BindingResult result) {
        if (result.hasErrors()) {
            return "quanly/nhanvien/update-nhanvien";
        }

        if (nhanVienRepository.existsById(id)) {
            nhanVien.setId(id); // Đảm bảo ID không bị thay đổi
            nhanVien.setNgaySua(LocalDate.now());
            nhanVienRepository.save(nhanVien);
        }

        return "redirect:/nhan-vien/hien-thi";
    }

}
