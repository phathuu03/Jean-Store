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
import com.example.demo.services.HinhAnhService;
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
    private QuanJeansChiTietRepository quanJeansChiTietRepository;

    @Autowired
    private QuanJeansRepository quanJeansRepository;

    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private SizeRepository sizeRepository;

    @Autowired
    private HinhAnhService hinhAnhService;  // Thêm service để xử lý hình ảnh

    // Hiển thị form thêm chi tiết quần jeans và hình ảnh
    @GetMapping("/add-san-pham-chi-tiet/{id}")
    public String showAddForm(@PathVariable Long id, Model model ) {
        QuanJeans quanJeans = quanJeansRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + id));

        List<MauSac> listMauSac = mauSacRepository.findAllByTrangThai(1);
        List<Size> listSize = sizeRepository.findAllByTrangThai(1);

        model.addAttribute("quanJeans", quanJeans);
        model.addAttribute("listMauSac", listMauSac);
        model.addAttribute("listSize", listSize);

        return "quanly/sanpham/add-san-pham-chi-tiet"; // Trang form để thêm chi tiết quần jeans
    }

    // Xử lý thêm chi tiết quần jeans và hình ảnh
    @PostMapping("/add")
    public String addQuanJeansChiTiet(@ModelAttribute QuanJeansChiTiet quanJeansChiTiet,
                                      @RequestParam("imageUrl") String imageUrl,
                                      @RequestParam("mauSacId") Long mauSacId) {
        MauSac mauSac = mauSacRepository.findById(mauSacId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy màu sắc với ID: " + mauSacId));

        // Thêm chi tiết quần jeans và hình ảnh
//        quanJeansChiTietService.addQuanJeansChiTiet(quanJeansChiTiet, imageUrl, mauSac);

        return "redirect:/api/quan-jeans/detail/" + quanJeansChiTiet.getQuanJeans().getId(); // Quay lại trang chi tiết quần jeans
    }

    // Hiển thị chi tiết quần jeans
    @GetMapping("/detail/{id}")
    public String viewDetail(@PathVariable Long id, Model model) {
        List<QuanJeansChiTiet> listChiTiet = quanJeansChiTietService.getAllByQuanJeansId(id);
        model.addAttribute("listQuanJeansChiTiet", listChiTiet);
        return "quanly/sanpham/detail"; // Trang hiển thị danh sách sản phẩm chi tiết
    }

    // Hiển thị danh sách quần jeans chi tiết
    @GetMapping
    public String listQuanJeansChiTiet(Model model) {
        List<QuanJeansChiTiet> list = quanJeansChiTietService.getAllQuanJeansChiTiet();
        model.addAttribute("quanJeansChiTietList", list);
        return "quan-jeans-chi-tiet/list";  // Trang hiển thị danh sách quần jeans chi tiết
    }

    // Hiển thị form chỉnh sửa chi tiết quần jeans
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        QuanJeansChiTiet quanJeansChiTiet = quanJeansChiTietService.getQuanJeansChiTietById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm chi tiết với ID: " + id));
        model.addAttribute("quanJeansChiTiet", quanJeansChiTiet);
        model.addAttribute("listMauSac", mauSacRepository.findAllByTrangThai(1));
        model.addAttribute("listSize", sizeRepository.findAllByTrangThai(1));
        return "quanly/sanpham/edit-san-pham-chi-tiet";
    }

    // Xử lý cập nhật sản phẩm chi tiết quần jeans
    @PostMapping("/update/{id}")
    public String updateQuanJeansChiTiet(@PathVariable Long id, @ModelAttribute QuanJeansChiTiet quanJeansChiTiet) {
        quanJeansChiTietService.updateQuanJeansChiTiet(id, quanJeansChiTiet);
        return "redirect:/api/quan-jeans/detail/" + quanJeansChiTiet.getQuanJeans().getId();
    }

    // Xóa sản phẩm chi tiết quần jeans
    @GetMapping("/delete/{id}")
    public String deleteQuanJeansChiTiet(@PathVariable Long id) {
        quanJeansChiTietService.deleteQuanJeansChiTiet(id);
        QuanJeansChiTiet quz = quanJeansChiTietRepository.findById(id).get();
        return "redirect:/api/quan-jeans/detail/" + quz.getQuanJeans().getId();
    }
}
