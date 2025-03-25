package com.example.demo.controller;

import com.example.demo.entity.ChatLieu;
import com.example.demo.entity.HoaDon;
import com.example.demo.services.HoaDonChiTietService;
import com.example.demo.services.HoaDonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class QuanLyDonHangController {
    @Autowired
    private HoaDonService hoaDonService;

    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;

    @GetMapping("/quanly/don-hang")
    public String quanLyTrangThaiDonHang(Model model,
                                         @RequestParam(defaultValue = "0") int page,
                                         @RequestParam(defaultValue = "15") int size,
                                         @RequestParam(defaultValue = "") String search) {

        Pageable pageable = PageRequest.of(page, size);

        // Nếu có tìm kiếm
        Page<HoaDon> hoaDons;
        if (!search.isEmpty()) {
            hoaDons = hoaDonService.searchHoaDon(search, pageable);  // Lấy kết quả tìm kiếm với phân trang
        } else {
            hoaDons = hoaDonService.getAllHoaDon(pageable);  // Lấy tất cả hóa đơn với phân trang
        }

        // Thêm thông tin vào model
        model.addAttribute("hoaDons", hoaDons.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hoaDons.getTotalPages());
        model.addAttribute("search", search);  // Thêm search vào model để duy trì tìm kiếm trên các trang phân trang

        return "quanly/trangthaidonhang/trangthaidonhang";
    }


//    @GetMapping("/chuyen-muc/chat-lieu")
//    public String quanLyChuyenMucChatLieu(Model model,
//                                          @RequestParam(defaultValue = "0") int page,
//                                          @RequestParam(defaultValue = "10") int size) {
//        Pageable pageable = PageRequest.of(page, size);
//        Page<ChatLieu> pageChatLieu = chatLieuService.getAllChatLieu(pageable);
//        model.addAttribute("listChatLieu", pageChatLieu.getContent());
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPages", pageChatLieu.getTotalPages());
//        return "quanly/thuoctinh/chat-lieu";
//    }

    @GetMapping("/view/detai-trang-thai/{id}")
    public String viewDetailTrangThai(@PathVariable Long id, Model model) {
        HoaDon hoaDon = hoaDonService.findHoaDonById(id);
        model.addAttribute("hoaDon", hoaDon);
        model.addAttribute("listHdct", hoaDonChiTietService.findAllByid(id));
        return "quanly/trangthaidonhang/detail";
    }

    @PostMapping("/xac-nhan-don-hang")
    @ResponseBody  // Đảm bảo trả về dưới dạng JSON
    public ResponseEntity<?> xacNhanDonHang(@RequestParam("hoaDonId") Long hoaDonId) {
        List<String> errorMessages = new ArrayList<>();

        // Gọi service với danh sách lỗi
        boolean success = hoaDonService.xacNhanTrangThai(hoaDonId, errorMessages);

        if (!success) {
            // Nếu có lỗi, trả về lỗi dưới dạng JSON
            return ResponseEntity.badRequest().body(errorMessages);
        }

        // Nếu không có lỗi, trả về trạng thái thành công
        return ResponseEntity.ok("Đơn hàng đã được xác nhận thành công.");
    }



    @PostMapping("/huy-don-hang")
    public String huyNhanDonHang(@RequestParam("hoaDonId") Long hoaDonId) {
        hoaDonService.huyDonHang(hoaDonId);
        return "redirect:/view/detai-trang-thai/" + hoaDonId;
    }

    @PostMapping("/xac-nhan-vc-nhan-don-hang")
    public String xnvcNhanDonHang(@RequestParam("hoaDonId") Long hoaDonId) {
        hoaDonService.xnvc(hoaDonId);
        return "redirect:/view/detai-trang-thai/" + hoaDonId;
    }

    @PostMapping("/hoan-thanh-don-hang")
    public String hoanThanhDonHang(@RequestParam("hoaDonId") Long hoaDonId) {
        hoaDonService.hoanThanhDonHang(hoaDonId);
        return "redirect:/view/detai-trang-thai/" + hoaDonId;
    }







}
