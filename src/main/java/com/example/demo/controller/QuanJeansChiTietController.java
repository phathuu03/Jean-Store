package com.example.demo.controller;

import com.example.demo.entity.*;
import com.example.demo.repository.MauSacRepository;
import com.example.demo.repository.QuanJeansChiTietRepository;
import com.example.demo.repository.QuanJeansRepository;
import com.example.demo.repository.SizeRepository;
import com.example.demo.services.CloudinaryService;
import com.example.demo.services.QuanJeansChiTietService;
import com.example.demo.services.HinhAnhService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
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

    @Autowired
    private CloudinaryService cloudinaryService;

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
                                      @RequestParam("imageFiles") MultipartFile[] imageFiles,
                                      Model model) {
        try {
            Long idMauSac = quanJeansChiTiet.getMauSac().getId();
            QuanJeans quanJean = quanJeansChiTiet.getQuanJeans();

            // Sử dụng CloudinaryService mới để tải ảnh lên song song và nhận danh sách URL
            List<String> uploadedImageUrls = cloudinaryService.uploadMultipleImages(imageFiles);

            // Lưu hình ảnh vào database nếu có ảnh được tải lên
            if (!uploadedImageUrls.isEmpty()) {
                uploadedImageUrls.forEach(url -> hinhAnhService.saveImage(url, quanJean, idMauSac));
            }

            // Lưu thông tin chi tiết quần jeans vào database
            quanJeansChiTietService.addQuanJeansChiTiet(quanJeansChiTiet);

            return "redirect:/api/quan-jean/detail/" + quanJeansChiTiet.getQuanJeans().getId();
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải ảnh lên Cloudinary: " + e.getMessage());
            return "error"; // Hiển thị trang lỗi nếu xảy ra vấn đề
        }
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

        List<HinhAnh> has = hinhAnhService.getHaByQuanJensAndMauSac(quanJeansChiTiet.getQuanJeans().getId(), quanJeansChiTiet.getMauSac().getId());
        model.addAttribute("listHinhAnh", has);


        return "quanly/sanpham/edit-san-pham-chi-tiet";
    }

    @PostMapping("/update/{id}")
    public String updateQuanJeansChiTiet(
            @PathVariable Long id,
            @ModelAttribute QuanJeansChiTiet quanJeansChiTiet,
            @RequestParam("imageFiles") MultipartFile[] imageFiles,
            @RequestParam("deletedImages") String deletedImagesJson) {

        // Chuyển đổi chuỗi JSON thành List<Long>
        ObjectMapper mapper = new ObjectMapper();
        List<Long> deletedImageIds = null;
        try {
            deletedImageIds = mapper.readValue(deletedImagesJson, new TypeReference<List<Long>>() {});
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Nếu có danh sách ảnh bị xóa thì gọi service xóa ảnh trong DB
        if (deletedImageIds != null && !deletedImageIds.isEmpty()) {
            hinhAnhService.deleteImagesByIds(deletedImageIds);
        }



        // Cập nhật thông tin sản phẩm chi tiết
        quanJeansChiTietService.updateQuanJeansChiTiet(id, quanJeansChiTiet);
        try {
            Long idMauSac = quanJeansChiTiet.getMauSac().getId();
            QuanJeans quanJean = quanJeansChiTiet.getQuanJeans();

            // Sử dụng CloudinaryService mới để tải ảnh lên song song và nhận danh sách URL
            List<String> uploadedImageUrls = cloudinaryService.uploadMultipleImages(imageFiles);

            // Lưu hình ảnh vào database nếu có ảnh được tải lên
            if (!uploadedImageUrls.isEmpty()) {
                uploadedImageUrls.forEach(url -> hinhAnhService.saveImage(url, quanJean, idMauSac));
            }

            // Lưu thông tin chi tiết quần jeans vào database
            quanJeansChiTietService.addQuanJeansChiTiet(quanJeansChiTiet);

            return "redirect:/api/quan-jean/detail/" + quanJeansChiTiet.getQuanJeans().getId();
        } catch (Exception ignored) {
        }
        return "redirect:/api/quan-jean/detail/" + quanJeansChiTiet.getQuanJeans().getId();
    }

    // Xóa sản phẩm chi tiết quần jeans
    @GetMapping("/delete/{id}")
    public String deleteQuanJeansChiTiet(@PathVariable Long id) {
        quanJeansChiTietService.deleteQuanJeansChiTiet(id);
        QuanJeansChiTiet quz = quanJeansChiTietRepository.findById(id).get();
        return "redirect:/api/quan-jean/detail/" + quz.getQuanJeans().getId();
    }
}
