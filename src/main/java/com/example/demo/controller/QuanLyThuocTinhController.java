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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;

@Controller
@RequestMapping("/api/quan-ly")
public class QuanLyThuocTinhController {

    @Autowired
    private ChatLieuService chatLieuService;

    @Autowired
    private OngQuanService ongQuanService;

    @Autowired
    private ThuongHieuService thuongHieuService;


    @GetMapping("/chuyen-muc/chat-lieu")
    public String quanLyChuyenMucChatLieu(Model model,
                                          @RequestParam(defaultValue = "0") int page,
                                          @RequestParam(defaultValue = "10") int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ChatLieu> pageChatLieu = chatLieuService.getAllChatLieu(pageable);
        model.addAttribute("listChatLieu", pageChatLieu.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageChatLieu.getTotalPages());
        return "quanly/thuoctinh/chat-lieu";
    }


    @GetMapping("/chuyen-muc/ong-quan")
    public String quanLyChuyenMucOngQuan(Model model,
                                         @RequestParam(defaultValue = "0") int page,
                                         @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<OngQuan> pageOngQuan = ongQuanService.getAllOngQuan(pageable);

        model.addAttribute("listOngQuan", pageOngQuan.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageOngQuan.getTotalPages());
        return "quanly/thuoctinh/ong-quan";
    }

    @GetMapping("/chuyen-muc/thuong-hieu")
    public String quanLyChuyenMucThuongHieu(Model model,
                                            @RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ThuongHieu> pageThuongHieu = thuongHieuService.getAllThuongHieu(pageable);

        model.addAttribute("listThuongHieu", pageThuongHieu.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageThuongHieu.getTotalPages());
        return "quanly/thuoctinh/thuong-hieu";
    }


    // Thêm mới ChatLieu
//    @PostMapping("/new-chat-lieu")
//    public String saveChatLieu(@ModelAttribute ChatLieu chatLieu,
//                               @RequestParam(defaultValue = "0") int page,
//                               @RequestParam(defaultValue = "10") int size,
//                               Model model) {
//        // Kiểm tra tên chất liệu đã tồn tại
//        if(chatLieuService.exitsChatLieu(chatLieu.getTenChatLieu())){
//            model.addAttribute("error", "Tên chất liệu này đã tồn tại!");
//
//            // Truyền lại danh sách chất liệu đã phân trang
//            Pageable pageable = PageRequest.of(page, size);
//            Page<ChatLieu> chatLieuPage = chatLieuService.getAllChatLieu(pageable);
//
//            model.addAttribute("listChatLieu", chatLieuPage.getContent());
//            model.addAttribute("currentPage", page);
//            model.addAttribute("totalPages", chatLieuPage.getTotalPages());
//
//            return "redirect:/api/quan-ly/chuyen-muc/chat-lieu" ; // Trả về trang quản lý chất liệu với thông báo lỗi
//        }
//
//        // Lưu chất liệu nếu không có lỗi
//        chatLieuService.saveChatLieu(chatLieu);
//        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";  // Redirect đến trang danh sách chất liệu
//    }
    @PostMapping("/new-chat-lieu")
    public String saveChatLieu(@ModelAttribute ChatLieu chatLieu,
                               RedirectAttributes redirectAttributes) {
        // Kiểm tra tên chất liệu đã tồn tại
        if (chatLieuService.exitsChatLieu(chatLieu.getTenChatLieu())) {
            redirectAttributes.addFlashAttribute("error", "Tên chất liệu này đã tồn tại!");
            return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";  // Redirect về trang quản lý chất liệu
        }

        // Lưu chất liệu nếu không có lỗi
        chatLieuService.saveChatLieu(chatLieu);
        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";  // Redirect về trang danh sách chất liệu
    }


    // Xóa ChatLieu (chuyển trạng thái thành không hoạt động)
    @GetMapping("/delete-chat-lieu/{id}")
    public String deleteChatLieu(@PathVariable Long id) {
        chatLieuService.deleteChatLieu(id);
        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";
    }

    //    // Thêm mới OngQuan
//    @PostMapping("/new-ong-quan")
//    public String saveOngQuan(@ModelAttribute OngQuan ongQuan) {
//        ongQuanService.saveOngQuan(ongQuan);
//        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";
//    }
    @PostMapping("/new-ong-quan")
    public String saveOngQuan(@ModelAttribute OngQuan ongQuan,

                              RedirectAttributes redirectAttributes) {
        // Kiểm tra tên OngQuan đã tồn tại
        if (ongQuanService.existsOngQuan(ongQuan.getTenOngQuan())) {
            // Nếu tên đã tồn tại, truyền thông báo lỗi và các thông tin phân trang
            redirectAttributes.addFlashAttribute("error", "Tên ống quần này đã tồn tại!");


            return "redirect:/api/quan-ly/chuyen-muc/ong-quan";  // Redirect về trang quản lý Ong Quan
        }

        // Lưu OngQuan nếu không có lỗi
        ongQuanService.saveOngQuan(ongQuan);
        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";  // Redirect về trang danh sách Ong Quan
    }


    // Xóa OngQuan (chuyển trạng thái thành không hoạt động)
    @GetMapping("/delete-ong-quan/{id}")
    public String deleteOngQuan(@PathVariable Long id) {
        ongQuanService.deleteOngQuan(id);
        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";
    }

//    // Thêm mới ThuongHieu
//    @PostMapping("/new-thuong-hieu")
//    public String saveThuongHieu(@ModelAttribute ThuongHieu thuongHieu) {
//        thuongHieuService.saveThuongHieu(thuongHieu);
//        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
//    }

    @PostMapping("/new-thuong-hieu")
    public String saveThuongHieu(@ModelAttribute ThuongHieu thuongHieu,
                                 RedirectAttributes redirectAttributes) {
        // Kiểm tra tên thương hiệu đã tồn tại
        if (thuongHieuService.existsThuongHieu(thuongHieu.getTenThuongHieu())) {
            // Nếu tên đã tồn tại, truyền thông báo lỗi và các thông tin phân trang
            redirectAttributes.addFlashAttribute("error", "Tên thương hiệu này đã tồn tại!");
            return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
        }

        thuongHieuService.saveThuongHieu(thuongHieu);
        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
    }


    // Xóa ThuongHieu (chuyển trạng thái thành không hoạt động)
    @GetMapping("/delete-thuong-hieu/{id}")
    public String deleteThuongHieu(@PathVariable Long id) {
        thuongHieuService.deleteThuongHieu(id);
        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
    }


//     Chỉnh sửa ChatLieu
    @GetMapping("/edit-chat-lieu/{id}")
    public String editChatLieu(@PathVariable Long id, Model model) {
        ChatLieu chatLieu = chatLieuService.getChatLieuById(id);
        model.addAttribute("chatLieu", chatLieu);
        return "quanly/thuoctinh/edit-chat-lieu"; // Trang để chỉnh sửa
    }
    @PostMapping("/update-chat-lieu")
    public String updateChatLieu(@ModelAttribute ChatLieu chatLieu, Model model) {
        // Lấy đối tượng ChatLieu hiện tại từ cơ sở dữ liệu
        ChatLieu existingChatLieu = chatLieuService.getChatLieuById(chatLieu.getId());

        // Kiểm tra tên chất liệu đã tồn tại và không phải là chính bản ghi hiện tại
        if (chatLieuService.exitsChatLieu(chatLieu.getTenChatLieu()) &&
                !existingChatLieu.getTenChatLieu().equals(chatLieu.getTenChatLieu())) {
            model.addAttribute("error", "Tên chất liệu này đã tồn tại!");  // Thêm thông báo lỗi vào model
            model.addAttribute("chatLieu", chatLieu);  // Truyền lại đối tượng chatLieu
            return "quanly/thuoctinh/edit-chat-lieu";  // Giữ lại trang chỉnh sửa
        }

        chatLieu.setNgaySua(new Date());
        chatLieuService.saveChatLieu(chatLieu); // Cập nhật thông tin
        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";  // Redirect về trang danh sách ChatLieu
    }



    // Cập nhật ChatLieu
//    @PostMapping("/update-chat-lieu")
//    public String updateChatLieu(@ModelAttribute ChatLieu chatLieu) {
//        chatLieu.setNgaySua(new Date());
//        chatLieuService.saveChatLieu(chatLieu); // Cập nhật thông tin
//        return "redirect:/api/quan-ly/chuyen-muc/chat-lieu";
//    }

    // Tương tự cho OngQuan và ThuongHieu
    @GetMapping("/edit-ong-quan/{id}")
    public String editOngQuan(@PathVariable Long id, Model model) {
        OngQuan ongQuan = ongQuanService.getOngQuanById(id);
        model.addAttribute("ongQuan", ongQuan);
        return "quanly/thuoctinh/edit-ong-quan"; // Trang để chỉnh sửa
    }

//    @PostMapping("/update-ong-quan")
//    public String updateOngQuan(@ModelAttribute OngQuan ongQuan) {
//        ongQuan.setNgaySua(new Date());
//        ongQuanService.saveOngQuan(ongQuan);
//        return "redirect:/api/quan-ly/chuyen-muc/ong-quan";
//    }
@PostMapping("/update-ong-quan")
public String updateOngQuan(@ModelAttribute OngQuan ongQuan, Model model) {
    // Lấy đối tượng OngQuan hiện tại từ cơ sở dữ liệu
    OngQuan existingOngQuan = ongQuanService.getOngQuanById(ongQuan.getId());

    // Kiểm tra tên ống quần đã tồn tại và không phải là chính bản ghi hiện tại
    if (ongQuanService.existsOngQuan(ongQuan.getTenOngQuan()) &&
            !existingOngQuan.getTenOngQuan().equals(ongQuan.getTenOngQuan())) {
        model.addAttribute("error", "Tên ống quần này đã tồn tại!");  // Thêm thông báo lỗi vào model
        model.addAttribute("ongQuan", ongQuan);  // Truyền lại đối tượng ongQuan
        return "quanly/thuoctinh/edit-ong-quan";  // Giữ lại trang chỉnh sửa
    }

    ongQuan.setNgaySua(new Date());
    ongQuanService.saveOngQuan(ongQuan);  // Cập nhật thông tin
    return "redirect:/api/quan-ly/chuyen-muc/ong-quan";  // Redirect về trang danh sách OngQuan
}



    @GetMapping("/edit-thuong-hieu/{id}")
    public String editThuongHieu(@PathVariable Long id, Model model) {
        ThuongHieu thuongHieu = thuongHieuService.getThuongHieuById(id);
        model.addAttribute("thuongHieu", thuongHieu);
        return "quanly/thuoctinh/edit-thuong-hieu"; // Trang để chỉnh sửa
    }

//    @PostMapping("/update-thuong-hieu")
//    public String updateThuongHieu(@ModelAttribute ThuongHieu thuongHieu) {
//        thuongHieu.setNgaySua(new Date());
//        thuongHieuService.saveThuongHieu(thuongHieu);
//        return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";
//    }
@PostMapping("/update-thuong-hieu")
public String updateThuongHieu(@ModelAttribute ThuongHieu thuongHieu, Model model) {
    // Lấy đối tượng ThuongHieu hiện tại từ cơ sở dữ liệu
    ThuongHieu existingThuongHieu = thuongHieuService.getThuongHieuById(thuongHieu.getId());

    // Kiểm tra tên thương hiệu đã tồn tại và không phải là chính bản ghi hiện tại
    if (thuongHieuService.existsThuongHieu(thuongHieu.getTenThuongHieu()) &&
            !existingThuongHieu.getTenThuongHieu().equals(thuongHieu.getTenThuongHieu())) {
        model.addAttribute("error", "Tên thương hiệu này đã tồn tại!");  // Thêm thông báo lỗi vào model
        model.addAttribute("thuongHieu", thuongHieu);  // Truyền lại đối tượng thuongHieu
        return "quanly/thuoctinh/edit-thuong-hieu";  // Giữ lại trang chỉnh sửa
    }

    thuongHieu.setNgaySua(new Date());
    thuongHieuService.saveThuongHieu(thuongHieu);  // Cập nhật thông tin
    return "redirect:/api/quan-ly/chuyen-muc/thuong-hieu";  // Redirect về trang danh sách ThuongHieu
}



}
