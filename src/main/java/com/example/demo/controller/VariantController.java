package com.example.demo.controller;

import com.example.demo.entity.MauSac;
import com.example.demo.entity.Size;
import com.example.demo.services.KichThuocService;
import com.example.demo.services.MauSacService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/api/quan-ly")
public class VariantController {

    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private KichThuocService sizeService;

    // Hiển thị danh sách Màu sắc và Kích thước


        @GetMapping("/list-kich-thuoc")
        public String listKichThuoc(@RequestParam(defaultValue = "0") int page,
                                    @RequestParam(defaultValue = "10") int size,
                                    Model model) {
            // Thiết lập Pageable để phân trang
            Pageable pageable = PageRequest.of(page, size);

            // Lấy danh sách kích thước với phân trang
            Page<Size> sizePage = sizeService.findAll(pageable); // Cập nhật service để trả về Page<Size>

            // Thêm dữ liệu vào model
            model.addAttribute("sizeList", sizePage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", sizePage.getTotalPages());

            // Trả về view với danh sách kích thước phân trang
            return "quanly/bienthe/kichthuoc/kichthuoc";
        }


    @GetMapping("/list-mau-sac")
    public String listMauSac(@RequestParam(defaultValue = "0") int page,
                             @RequestParam(defaultValue = "10") int size,
                             Model model) {
        // Thiết lập Pageable để phân trang
        Pageable pageable = PageRequest.of(page, size);

        // Lấy danh sách màu sắc với phân trang
        Page<MauSac> mauSacPage = mauSacService.findAll(pageable);  // Cập nhật service để trả về Page<MauSac>

        // Thêm dữ liệu vào model
        model.addAttribute("listMauSac", mauSacPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", mauSacPage.getTotalPages());

        // Trả về view với danh sách màu sắc phân trang
        return "quanly/bienthe/mausac/mausac";  // Trang quản lý màu sắc
    }




//    // Xử lý thêm Màu sắc
//    @PostMapping("/add-mau-sac")
//    public String addMauSac(@ModelAttribute MauSac mauSac) {
//        mauSacService.save(mauSac);
//        return "redirect:/api/quan-ly/list-mau-sac";  // Quay lại danh sách màu sắc
//    }

    @PostMapping("/add-mau-sac")
    public String addMauSac(@ModelAttribute MauSac mauSac,
                            RedirectAttributes redirectAttributes) {
        // Kiểm tra tên màu sắc đã tồn tại
        if(mauSacService.existsMauSac(mauSac.getTenMauSac())) {
            // Nếu tên đã tồn tại, truyền thông báo lỗi và các thông tin phân trang
            redirectAttributes.addFlashAttribute("error", "Tên màu sắc này đã tồn tại!");

            return "redirect:/api/quan-ly/list-mau-sac";  // Redirect về trang quản lý Màu Sắc
        }

        // Lưu Màu Sắc nếu không có lỗi
        mauSacService.save(mauSac);
        return "redirect:/api/quan-ly/list-mau-sac";  // Redirect về trang danh sách Màu Sắc
    }




    // Xử lý thêm Kích thước
//    @PostMapping("/add-size")
//    public String addSize(@ModelAttribute Size size) {
//        sizeService.save(size);
//        return "redirect:/api/quan-ly/list-kich-thuoc";  // Quay lại danh sách kích thước
//    }

    @PostMapping("/add-size")
    public String addSize(@ModelAttribute Size size,
                          RedirectAttributes redirectAttributes) {
        // Kiểm tra tên kích thước đã tồn tại
        if(sizeService.exitsSize(size.getTenSize())) {
            // Nếu tên đã tồn tại, truyền thông báo lỗi và các thông tin phân trang
            redirectAttributes.addFlashAttribute("error", "Kích thước này đã tồn tại!");

            return "redirect:/api/quan-ly/list-kich-thuoc";  // Redirect về trang quản lý Kích Thước
        }

        // Lưu Kích Thước nếu không có lỗi
        sizeService.save(size);
        return "redirect:/api/quan-ly/list-kich-thuoc";  // Redirect về trang danh sách Kích Thước
    }


    // Hiển thị form chỉnh sửa Màu sắc
    @GetMapping("/edit-mau-sac/{id}")
    public String editMauSac(@PathVariable Long id, Model model) {
        MauSac mauSac = mauSacService.findById(id);
        model.addAttribute("mauSac", mauSac);
        return "quanly/bienthe/mausac/edit-mau-sac";  // Điều hướng tới file JSP cho sửa màu sắc
    }

    // Xử lý chỉnh sửa Màu sắc
//    @PostMapping("/edit-mau-sac")
//    public String updateMauSac( @ModelAttribute MauSac mauSac) {
//        mauSac.setNgaySua(new Date());
//        mauSacService.save(mauSac);
//        return "redirect:/api/quan-ly/list-mau-sac";  // Quay lại danh sách màu sắc
//    }
    @PostMapping("/edit-mau-sac")
    public String updateMauSac(@ModelAttribute MauSac mauSac, RedirectAttributes redirectAttributes) {
        // Kiểm tra tên màu sắc đã tồn tại và không phải là chính bản ghi hiện tại
        if (mauSacService.existsMauSac(mauSac.getTenMauSac()) &&
                !mauSacService.findById(mauSac.getId()).getTenMauSac().equals(mauSac.getTenMauSac())) {
            redirectAttributes.addFlashAttribute("error", "Tên màu sắc này đã tồn tại!");
            return "redirect:/api/quan-ly/edit-mau-sac/" + mauSac.getId();  // Quay lại trang chỉnh sửa
        }

        mauSac.setNgaySua(new Date());
        mauSacService.save(mauSac);  // Cập nhật thông tin
        return "redirect:/api/quan-ly/list-mau-sac";  // Quay lại danh sách màu sắc
    }

    // Hiển thị form chỉnh sửa Kích thước
    @GetMapping("/edit-size/{id}")
    public String editSize(@PathVariable Long id, Model model) {
        Size size = sizeService.findById(id);
        model.addAttribute("size", size);
        return "quanly/bienthe/kichthuoc/edit-kich-thuoc";  // Điều hướng tới file JSP cho sửa kích thước
    }

    // Xử lý chỉnh sửa Kích thước
//    @PostMapping("/edit-size")
//    public String updateSize( @ModelAttribute Size size) {
//        size.setNgaySua(new Date());
//        sizeService.save(size);
//        return "redirect:/api/quan-ly/list-kich-thuoc";  // Quay lại danh sách kích thước
//    }
    @PostMapping("/edit-size")
    public String updateSize(@ModelAttribute Size size, RedirectAttributes redirectAttributes) {
        // Kiểm tra tên kích thước đã tồn tại và không phải là chính bản ghi hiện tại
        if (sizeService.exitsSize(size.getTenSize()) &&
                !sizeService.findById(size.getId()).getTenSize().equals(size.getTenSize())) {
            redirectAttributes.addFlashAttribute("error", "Kích thước này đã tồn tại!");
            return "redirect:/api/quan-ly/edit-size/" + size.getId();  // Quay lại trang chỉnh sửa
        }

        size.setNgaySua(new Date());
        sizeService.save(size);  // Cập nhật thông tin
        return "redirect:/api/quan-ly/list-kich-thuoc";  // Quay lại danh sách kích thước
    }

    // Cập nhật trạng thái Màu sắc thành "Không hoạt động"
    @GetMapping("/deactivate-mau-sac/{id}")
    public String deactivateMauSac(@PathVariable Long id) {
        mauSacService.deactivate(id);
        return "redirect:/api/quan-ly/list-mau-sac";  // Quay lại danh sách màu sắc
    }

    // Cập nhật trạng thái Kích thước thành "Không hoạt động"
    @GetMapping("/deactivate-size/{id}")
    public String deactivateSize(@PathVariable Long id) {
        sizeService.deactivate(id);
        return "redirect:/api/quan-ly/list-kich-thuoc";  // Quay lại danh sách kích thước
    }
}
