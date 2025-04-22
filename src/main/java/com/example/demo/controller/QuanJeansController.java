package com.example.demo.controller;

import com.example.demo.entity.QuanJeans;
import com.example.demo.services.*;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

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
    public String hienThiQuan(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "25") int size,
                              @RequestParam(defaultValue = "") String search, // Dùng cho tìm kiếm
                              Model model) {
        // Tạo Pageable cho phân trang
        Pageable pageable = PageRequest.of(page, size);


        Page<QuanJeans> quanJeans;

        if (!search.isEmpty()) {
            quanJeans = quanJeansService.getAllQuanJean(search, pageable);
        } else {
            quanJeans = quanJeansService.getAllQuanJean(pageable);
        }

        // Truyền vào model các dữ liệu liên quan đến phân trang và dữ liệu khác
        model.addAttribute("quanJeans", new QuanJeans());
        model.addAttribute("listQuanJean", quanJeans.getContent()); // Dữ liệu của trang hiện tại
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", quanJeans.getTotalPages());
        model.addAttribute("search", search);  // Truyền tham số search để giữ lại khi chuyển trang

        // Truyền thêm các dữ liệu khác (Không thay đổi)
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

        quanJeansService.saveQuanJean(quanJeans);
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

}
