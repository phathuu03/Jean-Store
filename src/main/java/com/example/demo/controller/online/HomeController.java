package com.example.demo.controller.online;

import com.example.demo.entity.QuanJeans;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class HomeController {
    @Autowired
    private OngQuanRepository ongQuanRepository;
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
    public String viewHome(Model model, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "12") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<QuanJeans> quanJeansPage = quanJeansRepository.findAllByTrangThai(pageable);

        model.addAttribute("thuongHieu", thuongHieu.findAll());
        model.addAttribute("quanJeans", quanJeansPage.getContent()); // Danh sách sản phẩm
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", quanJeansPage.getTotalPages());
        model.addAttribute("chatLieu", chatLieu.findAll());
        model.addAttribute("ongQuan", ongQuanRepository.findAll());
        return "online/home/home";
    }

    @GetMapping("/home/chatlieu")
    public String viewHomeChatLieu(@Param("id") Long id, Model model,
                                   @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "12") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<QuanJeans> quanJeansPage = quanJeansRepository.findAllByChatLieu(id, pageable);


        model.addAttribute("quanJeans", quanJeansPage.getContent()); // Danh sách sản phẩm
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", quanJeansPage.getTotalPages());

        model.addAttribute("thuongHieu", thuongHieu.findAll());
        model.addAttribute("chatLieu", chatLieu.findAll());
        model.addAttribute("ongQuan", ongQuanRepository.findAll());
        return "online/home/home";
    }

    @GetMapping("/home/ongquan")
    public String viewHomeOngQuan(@Param("id") Long id, Model model,
                                  @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "12") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<QuanJeans> quanJeansPage = quanJeansRepository.findAllByOngQuan(id, pageable);


        model.addAttribute("quanJeans", quanJeansPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", quanJeansPage.getTotalPages());


        model.addAttribute("thuongHieu", thuongHieu.findAll());
        model.addAttribute("chatLieu", chatLieu.findAll());
        model.addAttribute("ongQuan", ongQuanRepository.findAll());
        return "online/home/home";
    }

    @GetMapping("/home/thuonghieu")
    public String viewHomeThuongHieu(@Param("id") Long id, Model model,
                                     @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "12") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<QuanJeans> quanJeansPage = quanJeansRepository.findAllByThuongHieu(id, pageable);
        model.addAttribute("quanJeans", quanJeansPage.getContent()); // Danh sách sản phẩm
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", quanJeansPage.getTotalPages());
        model.addAttribute("thuongHieu", thuongHieu.findAll());
        model.addAttribute("chatLieu", chatLieu.findAll());
        model.addAttribute("ongQuan", ongQuanRepository.findAll());
        return "online/home/home";
    }

    @GetMapping("/home/product-detail")
    public String viewProductDetail(@RequestParam("id") Long id, Model model) {
        model.addAttribute("img", hinhAnhRepository.findHinhAnhByIdQuan(id));
        model.addAttribute("productDetail", quanJeansChiTietRepository.findQuanJeansChiTietByIdQuan(id));
        model.addAttribute("quanJeans", quanJeansRepository.findById(id).orElse(null));
        model.addAttribute("mauSac", mauSacRepository.findTenMauSac(id));
        return "online/home/product-detail";
    }

    @GetMapping("/getSizeByColor")
    @ResponseBody
    public ResponseEntity<?> getColor(@RequestParam("id") Long id, @RequestParam("colorId") Long colorId) {

        List<Object[]> size = sizeRepository.findByIdSize(id, colorId);
        return ResponseEntity.ok(Map.of("size", size));
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
    public ResponseEntity<?> getQuantity(@RequestParam("colorId") Long colorId, @RequestParam("sizeId") Long sizeId, @RequestParam("productId") Long productId) {

        Integer quantity = quanJeansChiTietRepository.getSoluong(productId, sizeId, colorId);
        if (quantity == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy."));
        }
        return ResponseEntity.ok(Map.of("quantity", quantity));
    }

    @GetMapping("/home/getIdProductDetail")
    @ResponseBody
    public ResponseEntity<?> getId(@RequestParam("colorId") Long colorId, @RequestParam("sizeId") Long sizeId, @RequestParam("productId") Long productId) {

        Long id = quanJeansChiTietRepository.getId(productId, sizeId, colorId);
        if (id == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy."));
        }
        return ResponseEntity.ok(Map.of("id", id));
    }
}
