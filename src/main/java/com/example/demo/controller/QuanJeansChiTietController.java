package com.example.demo.controller;

import com.example.demo.entity.QuanJeansChiTiet;
import com.example.demo.services.QuanJeansChiTietService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/quan-jeans-chi-tiet")
public class QuanJeansChiTietController {

    @Autowired
    private QuanJeansChiTietService quanJeansChiTietService;

    @GetMapping("/detail/{id}")
    public String viewDetail(@PathVariable Long id, Model model) {
        List<QuanJeansChiTiet> listChiTiet = quanJeansChiTietService.getAllByQuanJeansId(id);
        model.addAttribute("listQuanJeansChiTiet", listChiTiet);
        return "quanly/sanpham/detail"; // Trả về trang hiển thị danh sách sản phẩm chi tiết
    }

    // Hiển thị danh sách quần jeans chi tiết
    @GetMapping
    public String listQuanJeansChiTiet(Model model) {
        List<QuanJeansChiTiet> list = quanJeansChiTietService.getAllQuanJeansChiTiet();
        model.addAttribute("quanJeansChiTietList", list);
        return "quan-jeans-chi-tiet/list";  // Trả về trang giao diện list.html (hoặc .jsp)
    }

    // Hiển thị form thêm mới
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("quanJeansChiTiet", new QuanJeansChiTiet());
        return "quan-jeans-chi-tiet/add"; // Trả về trang thêm mới
    }

    // Xử lý thêm sản phẩm
    @PostMapping("/add")
    public String addQuanJeansChiTiet(@ModelAttribute QuanJeansChiTiet quanJeansChiTiet) {
        quanJeansChiTietService.addQuanJeansChiTiet(quanJeansChiTiet);
        return "redirect:/quan-jeans-chi-tiet"; // Chuyển hướng về danh sách
    }

    // Hiển thị form chỉnh sửa
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        QuanJeansChiTiet quanJeansChiTiet = quanJeansChiTietService.getQuanJeansChiTietById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm chi tiết với ID: " + id));
        model.addAttribute("quanJeansChiTiet", quanJeansChiTiet);
        return "quan-jeans-chi-tiet/edit"; // Trả về trang chỉnh sửa
    }

    // Xử lý cập nhật sản phẩm
    @PostMapping("/update/{id}")
    public String updateQuanJeansChiTiet(@PathVariable Long id, @ModelAttribute QuanJeansChiTiet quanJeansChiTiet) {
        quanJeansChiTietService.updateQuanJeansChiTiet(id, quanJeansChiTiet);
        return "redirect:/quan-jeans-chi-tiet"; // Chuyển hướng về danh sách
    }

    // Xóa sản phẩm
    @GetMapping("/delete/{id}")
    public String deleteQuanJeansChiTiet(@PathVariable Long id) {
        quanJeansChiTietService.deleteQuanJeansChiTiet(id);
        return "redirect:/quan-jeans-chi-tiet"; // Chuyển hướng về danh sách
    }
}
