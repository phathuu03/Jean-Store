package com.example.demo.controller.online;


import com.example.demo.entity.GioHangChiTiet;
import com.example.demo.entity.KhachHang;
import com.example.demo.entity.QuanJeansChiTiet;
import com.example.demo.repository.GioHangChiTietRepository;
import com.example.demo.repository.HinhAnhRepository;
import com.example.demo.repository.KhachHangRepository;
import com.example.demo.repository.QuanJeansChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class CartController {

    @Autowired
    private GioHangChiTietRepository gioHangChiTietRepository;
    @Autowired
    private HinhAnhRepository hinhAnhRepository;
    @Autowired
    private KhachHangRepository khachHangRepository;
    @Autowired
    private QuanJeansChiTietRepository quanJeansChiTietRepository;

    @GetMapping("cart/detail")
    public String cartView(Model model) {
        return "online/cart/cart-detail";
    }


    @GetMapping("/cart-detail/img")
    @ResponseBody
    public ResponseEntity<?> getImageByColor(@RequestParam("colorId") Long colorId, @RequestParam("productId") Long productId) {

        String imageUrl = hinhAnhRepository.findImageByColorAndProduct(colorId, productId);
        if (imageUrl == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy ảnh cho màu này."));
        }
        return ResponseEntity.ok(Map.of("imageUrl", imageUrl));
    }

//    @PostMapping("/cart/insert")
//    @ResponseBody
//    public ResponseEntity<?> insertCart(@RequestParam("idProductDetail") Long idProductDetail, @RequestParam("quantity") Integer quantity,@RequestParam("idKhachHang") Long idKhachHang) {
//
//        KhachHang khachHang = khachHangRepository.findById(idKhachHang).get();
//        QuanJeansChiTiet quanJeansChiTiet = quanJeansChiTietRepository.findById(idProductDetail).get();
//
//        GioHangChiTiet gioHangChiTiet = GioHangChiTiet.builder()
//                .moTa(null)
//                .trangThai(1)
//                .khachHang(khachHang)
//                .soLuong(quantity)
//                .quanJeansChiTiet(quanJeansChiTiet)
//        .build();
//
//        return ResponseEntity.ok(gioHangChiTietRepository.save(gioHangChiTiet));
//    }
}
