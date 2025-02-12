package com.example.demo.controller;

import com.example.demo.entity.Voucher;
import com.example.demo.repository.VoucherRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class VoucherController {
    @Autowired
    private VoucherRepository voucherRepository;

    @GetMapping("/voucher/hien-thi")
    public String hienThiVoucher(@RequestParam(value = "page", defaultValue = "0") int page,
                                 @RequestParam(value = "size", defaultValue = "5") int size,
                                 Model model) {
        // Lấy danh sách voucher từ database
        Pageable pageable = PageRequest.of(page, size);
        Page<Voucher> pageVoucher = voucherRepository.findAll(pageable);

        model.addAttribute("listVoucher", pageVoucher.getContent()); // Danh sách theo phân trang
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageVoucher.getTotalPages());
        model.addAttribute("size", size); // Truyền size để cập nhật dropdown

        return "/online/voucher/voucher";
    }



    @GetMapping("/voucher/view-add")
    public String viewAdd() {
        return "online/voucher/add-voucher";
    }

    @PostMapping("/voucher/add")
    public String add(@ModelAttribute("voucher") @Valid Voucher voucher, BindingResult result) {
        if (result.hasErrors()) {
            return "online/voucher/add-voucher";
        }
        voucherRepository.save(voucher);
        return "redirect:/voucher/hien-thi";
    }

    @GetMapping("/voucher/detail/{id}")
    public String detail(@PathVariable("id") Long id, Model model) {
        model.addAttribute("voucher", voucherRepository.findById(id).orElse(null));
        return "/online/voucher/detail-voucher";
    }

    @GetMapping("/voucher/view-update/{id}")
    public String viewUpdate(@PathVariable("id") Long id, Model model) {
        Optional<Voucher> optionalVoucher = voucherRepository.findById(id);
        if (optionalVoucher.isPresent()) {
            model.addAttribute("voucher", optionalVoucher.get());
            return "online/voucher/update-voucher";
        }
        return "redirect:/voucher/hien-thi";
    }

    @PostMapping("/voucher/update/{id}")
    public String updateVoucher(@PathVariable("id") Long id, @ModelAttribute("voucher") @Valid Voucher voucher, BindingResult result) {
        if (result.hasErrors()) {
            return "online/voucher/update-voucher";
        }

        if (voucherRepository.existsById(id)) {
            voucher.setId(id); // Đảm bảo ID không bị thay đổi
            voucherRepository.save(voucher);
        }

        return "redirect:/voucher/hien-thi";
    }

//    //tim kiem dang ngao:))
//    @GetMapping("/voucher/tim-kiem-ajax")
//    @ResponseBody
//    public List<Voucher> searchVoucherAjax(
//            @RequestParam(required = false) String keyword,
//            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) String startDate,
//            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) String endDate) {
//
//        LocalDate start = (startDate != null && !startDate.isEmpty()) ? LocalDate.parse(startDate) : null;
//        LocalDate end = (endDate != null && !endDate.isEmpty()) ? LocalDate.parse(endDate) : null;
//
//        return voucherRepository.findBySearchConditions(
//                keyword != null ? keyword : "", start, end);
//    }


}
