package com.example.demo.controller;

import com.example.demo.entity.QuanJeans;
import com.example.demo.repository.QuanJeansRepository;
import com.example.demo.services.ChatLieuService;
import com.example.demo.services.OngQuanService;
import com.example.demo.services.QuanJeanService;
import com.example.demo.services.ThuongHieuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/quanjeans")
    public String hienThiQuan(Model model) {
        model.addAttribute("listQuanJean", quanJeanService.getAllQuanJean());
        model.addAttribute("listOngQuan", ongQuanService.getAllOngQuan());
        model.addAttribute("listChatLieu", chatLieuService.getAllChatLieu());
        model.addAttribute("listThuongHieu", thuongHieuService.getAllThuongHieu());
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
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        QuanJeans quanJeans = quanJeanService.getQuanJeanById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có ID: " + id));
        model.addAttribute("quanJeans", quanJeans);
        return "quanly/sanpham/edit";
    }


}
