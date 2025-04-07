package com.example.demo.controller;

import com.example.demo.entity.HinhAnh;
import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.HinhAnhRepository;
import com.example.demo.repository.HoaDonRepository;
import com.example.demo.repository.KhachHangRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class KhachHangController {
    @Autowired
    private KhachHangRepository khachHangRepository;
    @Autowired
    private HoaDonRepository hoaDonRepository;
    @Autowired
    private HinhAnhRepository hinhAnhRepository;

    @GetMapping("/khach-hang")
    public String hienThiKhachHang(Model model) {
        model.addAttribute("list", khachHangRepository.findAll());
        return "quanly/khachhang/khachhang";
    }

    @GetMapping("/khach-hang/search")
    public String searchKhachHang(@RequestParam("query") String query, Model model) {
        List<KhachHang> ketQua = khachHangRepository.findByTenKhachHangContaining(query);
        model.addAttribute("list", ketQua);
        return "quanly/khachhang/khachhang";
    }

    @GetMapping("/khach-hang/detail/{id}")
    public String chiTietKhachHang(@PathVariable("id") Long id, Model model) {
        model.addAttribute("kh", khachHangRepository.findById(id).orElse(null));
        return "quanly/khachhang/detail-khachhang";
    }

    @GetMapping("/khach-hang/view-add")
    public String viewAdd() {
        return "quanly/khachhang/add-khachhang";
    }

    @PostMapping("/khach-hang/add")
    public String add(@ModelAttribute("kh") @Valid KhachHang khachHang, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("errors", result.getAllErrors());
            return "quanly/khachhang/add-khachhang";
        }
        khachHang.setNgayTao(new Date());
        khachHangRepository.save(khachHang);
        return "redirect:/khach-hang";
    }

    @GetMapping("/khach-hang/view-update/{id}")
    public String viewUpdateKhachHang(@PathVariable("id") Long id, Model model) {
        Optional<KhachHang> optionalKhachHang = khachHangRepository.findById(id);
        if (optionalKhachHang.isPresent()) {
            model.addAttribute("kh", optionalKhachHang.get());
            return "quanly/khachhang/update-khachhang";
        }
        return "redirect:/khach-hang";
    }

    @GetMapping("/khach-hang/viewDonHang/{id}")
    public String viewHoaDonKhachHang(@PathVariable("id") Long id, Model model) {
        List<HoaDon> list = hoaDonRepository.getHoaDonByIdKhachHang(id);
        Collections.reverse(list);
        model.addAttribute("hd",list );
        return "quanly/khachhang/viewDonHang";
    }

    @GetMapping("/khach-hang/viewDetailDonHang/{id}")
    public String viewHoaDonDetailKhachHang(@PathVariable("id") Long id, Model model) {
        model.addAttribute("hd", hoaDonRepository.findById(id).get());
        return "quanly/khachhang/viewDonHangDetail";
    }


    @PostMapping("/khach-hang/update/{id}")
    public String updateKhachHang(@PathVariable("id") Long id,
                                  @ModelAttribute("kh") @Valid KhachHang khachHang,
                                  BindingResult result,
                                  Model model) {
        if (result.hasErrors()) {
            model.addAttribute("kh", khachHang);
            return "quanly/khachhang/update-khachhang";
        }

        Optional<KhachHang> optionalKhachHang = khachHangRepository.findById(id);
        if (optionalKhachHang.isPresent()) {
            KhachHang existingKhachHang = optionalKhachHang.get();

            // Kiểm tra giá trị trạng thái nhận từ form
            System.out.println("Trạng thái từ form: " + khachHang.getTrangThai());

            // Cập nhật thông tin từ form
            existingKhachHang.setTenKhachHang(khachHang.getTenKhachHang());
            existingKhachHang.setTenDangNhap(khachHang.getTenDangNhap());
            existingKhachHang.setMatKhau(khachHang.getMatKhau());
            existingKhachHang.setSoDienThoai(khachHang.getSoDienThoai());
            existingKhachHang.setDiaChi(khachHang.getDiaChi());
            existingKhachHang.setEmail(khachHang.getEmail());
            existingKhachHang.setGioiTinh(khachHang.getGioiTinh());

            // Nếu form không gửi ngày tạo, giữ nguyên giá trị cũ
            if (khachHang.getNgayTao() != null) {
                existingKhachHang.setNgayTao(khachHang.getNgayTao());
            }

            // Kiểm tra nếu trạng thái không null mới cập nhật
            if (khachHang.getTrangThai() != null) {
                existingKhachHang.setTrangThai(khachHang.getTrangThai());
            }

            // Cập nhật ngày sửa
            existingKhachHang.setNgaySua(new Date());

            khachHangRepository.save(existingKhachHang);
        }
        return "redirect:/khach-hang";
    }


}
