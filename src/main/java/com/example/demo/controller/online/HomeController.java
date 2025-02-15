package com.example.demo.controller.online;

import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class HomeController {
    @Autowired
    private ThuongHieuRepository thuongHieu;
    @Autowired
    private QuanJeansRepository quanJeansRepository;
    @Autowired
    private QuanJeansChiTietRepository quanJeansChiTietRepository;
    @Autowired
    private ChatLieuRepository chatLieu;
    @Autowired
    private SizeRepository sizeRepository;
    @Autowired
    private MauSacRepository mauSacRepository;
    @Autowired
    private HinhAnhRepository hinhAnhRepository;

    @GetMapping("/home")
    public String viewHome(Model model) {
        model.addAttribute("thuongHieu", thuongHieu.findAll());
        model.addAttribute("quanJeans", quanJeansRepository.findAll());
        model.addAttribute("chatLieu", chatLieu.findAll());
        return "online/home/home";
    }

    @GetMapping("/home/product-detail")
    public String viewProductDetail(@RequestParam("id") Long id, Model model) {

        model.addAttribute("chatLieu", chatLieu.findAll());
        model.addAttribute("thuongHieu", thuongHieu.findAll());
        model.addAttribute("quanJeans", quanJeansRepository.findById(id).orElse(null));
        model.addAttribute("mauSac", mauSacRepository.findTenMauSac(id));
        model.addAttribute("size", sizeRepository.findByIdSize(id));
        return "online/home/product-detail";
    }


    @GetMapping("/home/product-detail/color")
    @ResponseBody
    public ResponseEntity<?> getImageByColor(@RequestParam("colorId") Long colorId, @RequestParam("productId") Long productId) {

        String imageUrl = hinhAnhRepository.findImageByColorAndProduct(colorId, productId);
        if (imageUrl == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy ảnh cho màu này."));
        }
        return ResponseEntity.ok(Map.of("imageUrl", imageUrl));
    }
    @GetMapping("/home/change-quantity")
    @ResponseBody
    public ResponseEntity<?> getQuantity(@RequestParam("colorId") Long colorId,@RequestParam("sizeId") Long sizeId, @RequestParam("productId") Long productId) {

        Integer quantity = quanJeansChiTietRepository.getSoluong(productId,sizeId,colorId);
        if (quantity == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy."));
        }
        return ResponseEntity.ok(Map.of("quantity", quantity));
    }
    @GetMapping("/home/getIdProductDetail")
    @ResponseBody
    public ResponseEntity<?> getId(@RequestParam("colorId") Long colorId,@RequestParam("sizeId") Long sizeId, @RequestParam("productId") Long productId) {

        Long id = quanJeansChiTietRepository.getId(productId,sizeId,colorId);
        if (id == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy."));
        }
        return ResponseEntity.ok(Map.of("id", id));
    }
}
