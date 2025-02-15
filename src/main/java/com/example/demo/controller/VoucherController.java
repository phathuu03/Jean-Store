package com.example.demo.controller;

import com.example.demo.entity.Voucher;
import com.example.demo.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class VoucherController {
    @Autowired
    private VoucherRepository voucherRepository;

    @GetMapping("/voucher/hien-thi")
    public String hienThiVoucher(Model model){
        model.addAttribute("listVoucher", voucherRepository.findAll());
        return "/quanly/voucher/voucher";
    }

    @GetMapping("/voucher/view-add")
    public String viewAdd() {
        return "add-voucher";
    }

    @PostMapping("/voucher/add")
    public String add(@ModelAttribute("voucher") Voucher voucher) {
        voucherRepository.save(voucher);
        return "redirect:/voucher/hien-thi";
    }
}
