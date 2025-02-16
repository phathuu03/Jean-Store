package com.example.demo.controller;

import com.example.demo.entity.ChatLieu;
import com.example.demo.entity.OngQuan;
import com.example.demo.entity.ThuongHieu;
import com.example.demo.services.ChatLieuService;
import com.example.demo.services.OngQuanService;
import com.example.demo.services.ThuongHieuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/api/quan-ly")
public class QuanLyThuocTinhController {

    @Autowired
    private ChatLieuService chatLieuService;

    @Autowired
    private OngQuanService ongQuanService;

    @Autowired
    private ThuongHieuService thuongHieuService;

    // Hiển thị quản lý các thực thể trong 1 view
    @GetMapping("/quanly-thuoctinh")
    public String quanLy(Model model) {
        model.addAttribute("listChatLieu", chatLieuService.getAllChatLieu());
        return "quanly/thuoctinh/thuoctinhsanpham";  // Chỉ có 1 view quanly.jsp
    }

    @GetMapping("/chuyen-muc/chat-lieu")
    public String quanLyChuyenMucChatLieu(Model model) {
        model.addAttribute("listChatLieu", chatLieuService.getAllChatLieu());
        return "quanly/thuoctinh/chat-lieu";  // Chỉ có 1 view quanly.jsp
    }
    @GetMapping("/chuyen-muc/chat-lieu/page")
    public String quanLyChuyenMucChatLieu(Model model,
                                          @RequestParam(defaultValue = "0") int page,
                                          @RequestParam(defaultValue = "5") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ChatLieu> pageChatLieu = chatLieuService.getAllChatLieu(pageable);

        model.addAttribute("listChatLieu", pageChatLieu.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageChatLieu.getTotalPages());
        return "quanly/thuoctinh/chat-lieu";
    }

    @GetMapping("/chuyen-muc/thuong-hieu")
    public String quanLyChuyenMucThuongHieu(Model model) {
        model.addAttribute("listThuongHieu", thuongHieuService.getAllThuongHieu());
        return "quanly/thuoctinh/thuong-hieu";  // Chỉ có 1 view quanly.jsp
    }

    @GetMapping("/chuyen-muc/ong-quan")
    public String quanLyChuyenMucOngQuan(Model model) {
        model.addAttribute("listOngQuan", ongQuanService.getAllOngQuan());
        return "quanly/thuoctinh/ong-quan";  // Chỉ có 1 view quanly.jsp
    }


    // Thêm mới ChatLieu
    @PostMapping("/new-chat-lieu")
    public String saveChatLieu(@ModelAttribute ChatLieu chatLieu) {
        chatLieuService.saveChatLieu(chatLieu);
        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu/page";
    }

    // Xóa ChatLieu (chuyển trạng thái thành không hoạt động)
    @GetMapping("/delete-chat-lieu/{id}")
    public String deleteChatLieu(@PathVariable Long id) {
        chatLieuService.deleteChatLieu(id);
        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";
    }

    // Thêm mới OngQuan
    @PostMapping("/new-ong-quan")
    public String saveOngQuan(@ModelAttribute OngQuan ongQuan) {
        ongQuanService.saveOngQuan(ongQuan);
        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";
    }

    // Xóa OngQuan (chuyển trạng thái thành không hoạt động)
    @GetMapping("/delete-ong-quan/{id}")
    public String deleteOngQuan(@PathVariable Long id) {
        ongQuanService.deleteOngQuan(id);
        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";
    }

    // Thêm mới ThuongHieu
    @PostMapping("/new-thuong-hieu")
    public String saveThuongHieu(@ModelAttribute ThuongHieu thuongHieu) {
        thuongHieuService.saveThuongHieu(thuongHieu);
        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
    }

    // Xóa ThuongHieu (chuyển trạng thái thành không hoạt động)
    @GetMapping("/delete-thuong-hieu/{id}")
    public String deleteThuongHieu(@PathVariable Long id) {
        thuongHieuService.deleteThuongHieu(id);
        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
    }


    // Chỉnh sửa ChatLieu
    @GetMapping("/edit-chat-lieu/{id}")
    public String editChatLieu(@PathVariable Long id, Model model) {
        ChatLieu chatLieu = chatLieuService.getChatLieuById(id);
        model.addAttribute("chatLieu", chatLieu);
        return "quanly/thuoctinh/edit-chat-lieu"; // Trang để chỉnh sửa
    }

    // Cập nhật ChatLieu
    @PostMapping("/update-chat-lieu")
    public String updateChatLieu(@ModelAttribute ChatLieu chatLieu) {
        chatLieuService.saveChatLieu(chatLieu); // Cập nhật thông tin
        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";
    }

    // Tương tự cho OngQuan và ThuongHieu
    @GetMapping("/edit-ong-quan/{id}")
    public String editOngQuan(@PathVariable Long id, Model model) {
        OngQuan ongQuan = ongQuanService.getOngQuanById(id);
        model.addAttribute("ongQuan", ongQuan);
        return "quanly/thuoctinh/edit-ong-quan"; // Trang để chỉnh sửa
    }

    @PostMapping("/update-ong-quan")
    public String updateOngQuan(@ModelAttribute OngQuan ongQuan) {
        ongQuanService.saveOngQuan(ongQuan);
        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";
    }

    @GetMapping("/edit-thuong-hieu/{id}")
    public String editThuongHieu(@PathVariable Long id, Model model) {
        ThuongHieu thuongHieu = thuongHieuService.getThuongHieuById(id);
        model.addAttribute("thuongHieu", thuongHieu);
        return "quanly/thuoctinh/edit-thuong-hieu"; // Trang để chỉnh sửa
    }

    @PostMapping("/update-thuong-hieu")
    public String updateThuongHieu(@ModelAttribute ThuongHieu thuongHieu) {
        thuongHieuService.saveThuongHieu(thuongHieu);
        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
    }

}
