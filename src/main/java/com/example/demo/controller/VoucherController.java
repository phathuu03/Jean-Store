package com.example.demo.controller;

import com.example.demo.entity.Voucher;
import com.example.demo.repository.VoucherRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class VoucherController {
    @Autowired
    private VoucherRepository voucherRepository;

    @GetMapping("voucher/hien-thi")
    public String hienThiVoucher(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size,
            @RequestParam(required = false) String keyword,
            Model model) {

        Pageable pageable = PageRequest.of(page, size);

        Page<Voucher> voucherPage;

        if (keyword != null && !keyword.isEmpty()) {
            voucherPage = voucherRepository.findByTenVoucherContainingIgnoreCase(keyword, pageable);
        } else {
            voucherPage = voucherRepository.findAll(pageable);
        }

        model.addAttribute("listVoucher", voucherPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", voucherPage.getTotalPages());
        model.addAttribute("size", size);
        model.addAttribute("keyword", keyword);

        return "quanly/voucher/voucher";
    }


    @GetMapping("/voucher/view-add")
    public String viewAdd() {
        return "quanly/voucher/add-voucher";
    }

    @PostMapping("/voucher/add")
    public String add(@ModelAttribute("voucher") @Valid Voucher voucher, BindingResult result, Model model) {
        if (voucher.getPhanTramGiamGia() <= 0 || voucher.getPhanTramGiamGia() > 100) {
            model.addAttribute("error2", "Phần trăm giảm giá phải lớn hơn 0 và nhỏ hơn 100");
            return "quanly/voucher/add-voucher";
        }
        if (voucher.getNgayBatDau().after(voucher.getNgayKetThuc())) {
            model.addAttribute("error1", "Ngày bắt đầu phải nhỏ hơn ngày kết thúc");
            return "quanly/voucher/add-voucher";
        }
        if (voucher.getDieuKienApDung() < voucher.getGiamGiaToiDa()) {
            model.addAttribute("error", "Giảm giá tối đa phải nhỏ hơn điều kiện áp dụng");
            return "quanly/voucher/add-voucher";
        }

        if (result.hasErrors()) {
            return "quanly/voucher/add-voucher";
        }


        // Kiểm tra nếu trạng thái chưa set gì thì mặc định là "Đang diễn ra"
        if (voucher.getTrangThai() == null) {
            voucher.setTrangThai(1); // 1 = Đang diễn ra
        }
        // Lưu đúng giá trị người dùng nhập
        voucherRepository.save(voucher);
        return "redirect:/voucher/hien-thi";
    }


    @GetMapping("/voucher/detail/{id}")
    public String detail(@PathVariable("id") Long id, Model model) {
        model.addAttribute("voucher", voucherRepository.findById(id).orElse(null));
        return "quanly/voucher/detail-voucher";
    }

    @GetMapping("/voucher/view-update/{id}")
    public String viewUpdate(@PathVariable("id") Long id, Model model) {
        Optional<Voucher> optionalVoucher = voucherRepository.findById(id);
        if (optionalVoucher.isPresent()) {
            model.addAttribute("voucher", optionalVoucher.get());
            return "quanly/voucher/update-voucher";
        }
        return "redirect:/voucher/hien-thi";
    }

    @PostMapping("/voucher/update/{id}")
    public String updateVoucher(
            @PathVariable("id") Long id,
            @ModelAttribute("voucher") @Valid Voucher voucher,
            BindingResult result,
            Model model) {

        if (voucher.getPhanTramGiamGia() <= 0 || voucher.getPhanTramGiamGia() > 100) {
            model.addAttribute("error2", "Phần trăm giảm giá phải lớn hơn 0 và nhỏ hơn 100");
            return "quanly/voucher/update-voucher";
        }
        if (voucher.getNgayBatDau().after(voucher.getNgayKetThuc())) {
            model.addAttribute("error1", "Ngày bắt đầu phải nhỏ hơn ngày kết thúc");
            return "quanly/voucher/update-voucher";

        }
        if (voucher.getDieuKienApDung() < voucher.getGiamGiaToiDa()) {
            model.addAttribute("error", "Giảm giá tối đa phải nhỏ hơn điều kiện áp dụng");
            return "quanly/voucher/update-voucher";
        }

        if (result.hasErrors()) {
            return "quanly/voucher/update-voucher";
        }

        if (voucherRepository.existsById(id)) {
            voucher.setId(id); // Đảm bảo ID không bị thay đổi

            // Kiểm tra và xử lý điều kiện áp dụng không hợp lệ
            if (voucher.getDieuKienApDung() < 0) {
                model.addAttribute("error", "Điều kiện áp dụng không thể nhỏ hơn 0!");
                return "quanly/voucher/update-voucher"; // Quay lại trang update và hiện lỗi
            }

            voucherRepository.save(voucher);
        }
        return "redirect:/voucher/hien-thi";
    }


    @GetMapping("/voucher/search")
    public String searchVoucher(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "6") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Voucher> pageVoucher;

        if (keyword == null || keyword.trim().isEmpty()) {
            pageVoucher = voucherRepository.findAll(pageable);
        } else {
            pageVoucher = voucherRepository.findByTenVoucherContainingIgnoreCase(keyword, pageable);
        }

        // Đảm bảo luôn có listVoucher, kể cả khi trống
        model.addAttribute("listVoucher", pageVoucher.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageVoucher.getTotalPages());
        model.addAttribute("size", size);
        model.addAttribute("keyword", keyword);

        return "quanly/voucher/voucher";
    }

}
