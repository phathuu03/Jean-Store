package com.example.demo.controller;

import com.example.demo.entity.QuanJeans;
import com.example.demo.repository.QuanJeansRepository;
import com.example.demo.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/api/quan-jean")
public class QuanJeanController {

    @Autowired
    private QuanJeanService quanJeanService;
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
        model.addAttribute("listQuanJean", quanJeanService.getAllQuanJean());
        model.addAttribute("listOngQuan", ongQuanService.getAllActiveOngQuan());
        model.addAttribute("listChatLieu", chatLieuService.getAllActiveChatLieu());
        model.addAttribute("listThuongHieu", thuongHieuService.getAllActiveThuongHieu());
        return "quanly/sanpham/sanpham";
    }

    @PostMapping("/new-quan-jean")
    public String saveQuanJean(@ModelAttribute QuanJeans quanJeans) {
        quanJeanService.saveQuanJean(quanJeans);
        return "redirect:/api/quan-jean/quanjeans";
    }

    // Xóa quần jeans theo ID
    @GetMapping("/delete/{id}")
    public String deleteQuanJean(@PathVariable Long id) {
        quanJeanService.deleteQuanJean(id);
        return "redirect:/api/quan-jean/quanjeans";
    }

    // Hiển thị form chỉnh sửa quần jeans
    @GetMapping("/detail/{id}")
    public String showDetailForm(@PathVariable Long id, Model model) {
        QuanJeans quanJeans = quanJeanService.getQuanJeanById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));
        model.addAttribute("quanJeans", quanJeans);
        model.addAttribute("listQuanJeans", quanJeansChiTietService.getAllByQuanJeansId(id));
        return "quanly/sanpham/detail";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        QuanJeans quanJeans = quanJeanService.getQuanJeanById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));

        model.addAttribute("quanJeans", quanJeans);
        model.addAttribute("listThuongHieu", thuongHieuService.getAllActiveThuongHieu());
        model.addAttribute("listChatLieu", chatLieuService.getAllActiveChatLieu());
        model.addAttribute("listOngQuan", ongQuanService.getAllActiveOngQuan());
        return "quanly/sanpham/edit";
    }


    @PostMapping("/update/{id}")
    public String updateQuanJean(@PathVariable Long id, @ModelAttribute QuanJeans quanJeans) {
        // Kiểm tra sản phẩm có tồn tại không
        QuanJeans existingQuanJeans = quanJeanService.getQuanJeanById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));

        // Cập nhật thông tin sản phẩm
        existingQuanJeans.setTenSanPham(quanJeans.getTenSanPham());
        existingQuanJeans.setTrangThai(quanJeans.getTrangThai());
        existingQuanJeans.setThuongHieu(quanJeans.getThuongHieu());
        existingQuanJeans.setChatLieu(quanJeans.getChatLieu());
        existingQuanJeans.setOngQuan(quanJeans.getOngQuan());
        existingQuanJeans.setNgaySua(LocalDate.now());

        // Lưu lại dữ liệu cập nhật
        quanJeanService.updateQuanJean(id,existingQuanJeans);

        return "redirect:/api/quan-jean/quanjeans"; // Quay lại danh sách sản phẩm
    }

    @GetMapping("/quanjeans-search")
    public String hienThiQuan(@RequestParam(value = "search", required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("listQuanJean", quanJeanService.searchQuanJean(search));  // Tìm kiếm sản phẩm theo từ khóa
        } else {
            model.addAttribute("listQuanJean", quanJeanService.getAllQuanJean());  // Hiển thị tất cả sản phẩm
        }

        model.addAttribute("listOngQuan", ongQuanService.getAllOngQuan());
        model.addAttribute("listChatLieu", chatLieuService.getAllChatLieu());
        model.addAttribute("listThuongHieu", thuongHieuService.getAllThuongHieu());
        return "quanly/sanpham/sanpham";
    }





}
