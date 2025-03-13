package com.example.demo.controller;

import com.example.demo.entity.HinhAnh;
import com.example.demo.entity.QuanJeans;
import com.example.demo.services.*;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api/quan-jean")
public class QuanJeansController {

    @Autowired
    private QuanJeanService quanJeansService;
    @Autowired
    private ChatLieuService chatLieuService;
    @Autowired
    private OngQuanService ongQuanService;
    @Autowired
    private ThuongHieuService thuongHieuService;
    @Autowired
    private QuanJeansChiTietService quanJeansChiTietService;



    @GetMapping("/quanjeans")
    public String hienThiQuan(Model model) {
        model.addAttribute("quanJeans", new QuanJeans());
        model.addAttribute("listQuanJean", quanJeansService.getAllQuanJean());
        model.addAttribute("listOngQuan", ongQuanService.getAllActiveOngQuan());
        model.addAttribute("listChatLieu", chatLieuService.getAllActiveChatLieu());
        model.addAttribute("listThuongHieu", thuongHieuService.getAllActiveThuongHieu());
        return "quanly/sanpham/sanpham";
    }

    @PostMapping("/new-quan-jean")
    public String saveQuanJean(@Valid @ModelAttribute QuanJeans quanJeans,
                               BindingResult bindingResult,
                               Model model
                               ) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("listQuanJean", quanJeansService.getAllQuanJean());
            model.addAttribute("listOngQuan", ongQuanService.getAllActiveOngQuan());
            model.addAttribute("listChatLieu", chatLieuService.getAllActiveChatLieu());
            model.addAttribute("listThuongHieu", thuongHieuService.getAllActiveThuongHieu());

            return "quanly/sanpham/sanpham";
        }
        QuanJeans savedQuanJeans = quanJeansService.saveQuanJean(quanJeans);
        return "redirect:/api/quan-jean/quanjeans";  // Quay lại trang danh sách sản phẩm
    }


    // Xóa quần jeans theo ID
    @GetMapping("/delete/{id}")
    public String deleteQuanJean(@PathVariable Long id) {
        quanJeansService.deleteQuanJean(id);
        return "redirect:/api/quan-jean/quanjeans";
    }

    // Hiển thị form chỉnh sửa quần jeans
    @GetMapping("/detail/{id}")
    public String showDetailForm(@PathVariable Long id, Model model) {
        QuanJeans quanJeans = quanJeansService.getQuanJeanById(id).orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));

        model.addAttribute("quanJeans", quanJeans);
        model.addAttribute("listQuanJeansChiTiet", quanJeansChiTietService.getAllByQuanJeansId(id));
//        model.addAttribute("hinhAnhs", quanJeans.getHinhAnhs());  // Hiển thị hình ảnh quần jeans

        return "quanly/sanpham/detail";  // Trang chi tiết sản phẩm quần jeans
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        QuanJeans quanJeans = quanJeansService.getQuanJeanById(id).orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));

        model.addAttribute("quanJeans", quanJeans);
        model.addAttribute("listThuongHieu", thuongHieuService.getAllActiveThuongHieu());
        model.addAttribute("listChatLieu", chatLieuService.getAllActiveChatLieu());
        model.addAttribute("listOngQuan", ongQuanService.getAllActiveOngQuan());
        return "quanly/sanpham/edit";
    }

    @PostMapping("/update/{id}")
    public String updateQuanJean(@PathVariable Long id, @ModelAttribute QuanJeans quanJeans) {
        // Kiểm tra sản phẩm có tồn tại không
        QuanJeans existingQuanJeans = quanJeansService.getQuanJeanById(id).orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));

        // Cập nhật thông tin sản phẩm
        existingQuanJeans.setTenSanPham(quanJeans.getTenSanPham());
        existingQuanJeans.setTrangThai(quanJeans.getTrangThai());
        existingQuanJeans.setThuongHieu(quanJeans.getThuongHieu());
        existingQuanJeans.setChatLieu(quanJeans.getChatLieu());
        existingQuanJeans.setOngQuan(quanJeans.getOngQuan());
        existingQuanJeans.setNgaySua(LocalDate.now());

        // Lưu lại dữ liệu cập nhật
        quanJeansService.updateQuanJean(id, existingQuanJeans);

        return "redirect:/api/quan-jean/quanjeans";  // Quay lại danh sách sản phẩm
    }

    // Tìm kiếm quần jeans
    @GetMapping("/quanjeans-search")
    public String searchQuanJeans(@RequestParam(value = "search", required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("listQuanJean", quanJeansService.searchQuanJean(search));  // Tìm kiếm sản phẩm theo từ khóa
        } else {
            model.addAttribute("listQuanJean", quanJeansService.getAllQuanJean());  // Hiển thị tất cả sản phẩm
        }

        model.addAttribute("listOngQuan", ongQuanService.getAllOngQuan());
        model.addAttribute("listChatLieu", chatLieuService.getAllChatLieu());
        model.addAttribute("listThuongHieu", thuongHieuService.getAllThuongHieu());
        return "quanly/sanpham/sanpham";  // Quay lại trang danh sách sản phẩm
    }
}
