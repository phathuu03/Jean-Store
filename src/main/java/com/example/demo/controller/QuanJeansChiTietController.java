package com.example.demo.controller;

import com.example.demo.entity.MauSac;
import com.example.demo.entity.QuanJeans;
import com.example.demo.entity.QuanJeansChiTiet;
import com.example.demo.entity.Size;
import com.example.demo.repository.MauSacRepository;
import com.example.demo.repository.QuanJeansChiTietRepository;
import com.example.demo.repository.QuanJeansRepository;
import com.example.demo.repository.SizeRepository;
import com.example.demo.services.QuanJeansChiTietService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("api/quan-jeans-chi-tiet")
public class QuanJeansChiTietController {

    @Autowired
    private QuanJeansChiTietService quanJeansChiTietService;


    @Autowired
    private QuanJeansRepository quanJeansRepository;

    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private SizeRepository sizeRepository;
    @Autowired
    private QuanJeansChiTietRepository quanJeansChiTietRepository;

    // Hiển thị form thêm mới
    @GetMapping("/add-san-pham-chi-tiet/{id}")
    public String showAddForm(@PathVariable Long id, Model model ) {
        QuanJeans quanJeans = quanJeansRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + id));

        List<MauSac> listMauSac = mauSacRepository.findAllByTrangThai(1);
        List<Size> listSize = sizeRepository.findAllByTrangThai(1);

        model.addAttribute("quanJeans", quanJeans);
        model.addAttribute("listMauSac", listMauSac);
        model.addAttribute("listSize", listSize);

        return "quanly/sanpham/add-san-pham-chi-tiet"; // Trả về trang JSP
    }

    // Xử lý thêm sản phẩm
    @PostMapping("/add")
    public String addQuanJeansChiTiet(@ModelAttribute QuanJeansChiTiet quanJeansChiTiet) {
        quanJeansChiTietService.addQuanJeansChiTiet(quanJeansChiTiet);
        return "redirect:/api/quan-jean/detail/" + quanJeansChiTiet.getQuanJeans().getId(); // Chuyển hướng về danh sách
    }



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





    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        QuanJeansChiTiet quanJeansChiTiet = quanJeansChiTietService.getQuanJeansChiTietById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm chi tiết với ID: " + id));
        model.addAttribute("quanJeansChiTiet", quanJeansChiTiet);
        model.addAttribute("listMauSac", mauSacRepository.findAllByTrangThai(1));
        model.addAttribute("listSize", sizeRepository.findAllByTrangThai(1));
        return "quanly/sanpham/edit-san-pham-chi-tiet";
    }


    // Xử lý cập nhật sản phẩm
    @PostMapping("/update/{id}")
    public String updateQuanJeansChiTiet(@PathVariable Long id, @ModelAttribute QuanJeansChiTiet quanJeansChiTiet) {
        quanJeansChiTietService.updateQuanJeansChiTiet(id, quanJeansChiTiet);
        return "redirect:/api/quan-jean/detail/" + quanJeansChiTiet.getQuanJeans().getId();
    }

    // Xóa sản phẩm
    @GetMapping("/delete/{id}")
    public String deleteQuanJeansChiTiet(@PathVariable Long id) {
        quanJeansChiTietService.deleteQuanJeansChiTiet(id);
        QuanJeansChiTiet quz = quanJeansChiTietRepository.findById(id).get();
        return "redirect:/api/quan-jean/detail/" + quz.getQuanJeans().getId();
    }


}
