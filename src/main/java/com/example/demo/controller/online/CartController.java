package com.example.demo.controller.online;


import com.example.demo.entity.GioHangChiTiet;
import com.example.demo.entity.GioHangChiTietDTO;
import com.example.demo.entity.KhachHang;
import com.example.demo.entity.QuanJeansChiTiet;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class CartController {

    @Autowired
    private GioHangChiTietRepository gioHangChiTietRepository;
    @Autowired
    private GioHangChiTietDTORepository gioHangChiTietDTORepository;
    @Autowired
    private HinhAnhRepository hinhAnhRepository;
    @Autowired
    private KhachHangRepository khachHangRepository;
    @Autowired
    private QuanJeansChiTietRepository quanJeansChiTietRepository;


    @GetMapping("cart/detail")
    public String cartView() {
        return "online/cart/cart-detail";
    }


    @GetMapping("/cart/detail/user")
    @ResponseBody
    public ResponseEntity<?> cartView(@RequestParam("id") Long id) {
        return ResponseEntity.ok(Map.of("cart", gioHangChiTietDTORepository.findGioHangChiTietByKhachHang_Id(id)));
    }


    @GetMapping("/cart-detail/img")
    @ResponseBody
    public ResponseEntity<?> getImageByColor(@RequestParam("colorId") Long colorId, @RequestParam("productId") Long productId) {

        List<String> imageUrl = hinhAnhRepository.findImageByColorAndProduct(colorId, productId);
        if (imageUrl == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy ảnh cho màu này."));
        }
        return ResponseEntity.ok(Map.of("imageUrl", imageUrl.get(0)));
    }

    @PostMapping("/cart/insert")
    @ResponseBody
    public ResponseEntity<?> insertCart(@RequestParam("idProductDetail") Long idProductDetail, @RequestParam("quantity") Integer quantity, @RequestParam("idKhachHang") Long idKhachHang) {
        int count = 0;

        List<GioHangChiTietDTO> gioHangChiTiets = gioHangChiTietDTORepository.findGioHangChiTietByKhachHang_Id(idKhachHang);

        for (GioHangChiTietDTO item : gioHangChiTiets) {
            if (item.getQuanJeansChiTietDTO().getId() == idProductDetail) {
                gioHangChiTietRepository.setSoLuong(quantity, idProductDetail, idKhachHang);
                count++;
                break;
            }
        }
        if (count != 0) {
            return ResponseEntity.ok("Cập nhật số lượng thành công");
        } else {

            KhachHang khachHang = khachHangRepository.findById(idKhachHang).get();
            QuanJeansChiTiet quanJeansChiTiet = quanJeansChiTietRepository.findById(idProductDetail).get();

            GioHangChiTiet gioHangChiTiet = GioHangChiTiet.builder()
                    .moTa(null)
                    .trangThai(1)
                    .khachHang(khachHang)
                    .soLuong(quantity)
                    .quanJeansChiTiet(quanJeansChiTiet)
                    .build();
            return ResponseEntity.ok(gioHangChiTietRepository.save(gioHangChiTiet));
        }
    }

    @DeleteMapping("/delete/cart")
    @ResponseBody
    public ResponseEntity<?> deleteCart(@RequestParam("id") Long id) {
        gioHangChiTietRepository.deleteGioHangChiTietByIdKhachHang(id);
        return ResponseEntity.ok("Xóa giỏ hàng thành công");
    }

    @DeleteMapping("/delete-cart/onclick")
    @ResponseBody
    public ResponseEntity<?> deleteCartByIdQuan(@RequestParam("idKhachHang") Long idKhachHang,@RequestParam("idQuan") Long idQuan) {
        gioHangChiTietRepository.deleteGioHangChiTietByIdKhachHangAndIdQuanJeansChiTiet(idKhachHang,idQuan);
        return ResponseEntity.ok("Xóa giỏ hàng thành công");
    }

    @PutMapping("/update-quantity/onclick")
    @ResponseBody
    public ResponseEntity<?> updateQuantityOnclick(@RequestParam("idProductDetail") Long idProductDetail, @RequestParam("quantity") Integer quantity, @RequestParam("idKhachHang") Long idKhachHang) {
        gioHangChiTietRepository.updateSoLuongOnClickCart(quantity,idProductDetail,idKhachHang);
        return ResponseEntity.ok(Map.of("mes","Cập nhật số lượng thành công"));
    }

}
