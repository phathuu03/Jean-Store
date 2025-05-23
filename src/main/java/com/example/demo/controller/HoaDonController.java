package com.example.demo.controller;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.services.HinhAnhService;
import com.example.demo.services.HoaDonChiTietService;
import com.example.demo.services.HoaDonService;
import com.example.demo.services.QuanJeansChiTietService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/api/quan-ly/hoa-don")
public class HoaDonController {
    @Autowired
    private HoaDonService hoaDonService;

    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;

    @Autowired
    KhachHangRepository khachHangRepository;

    @Autowired
    NhanVienRepository nhanVienRepository;

    @Autowired
    VoucherRepository voucherRepository;

    @Autowired
    PTTTRepository ptttRepository;

    @Autowired
    QuanJeansChiTietService quanJeansChiTietService;

    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private SizeRepository sizeRepository;

    @Autowired
    private HinhAnhService hinhAnhService;

    @GetMapping("/view-hoa-don")
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
            hoaDons = hoaDonService.getAllHoaDon(pageable);  // Lấy tất cả hóa đơn với phân trang, đã đảo ngược
        }

        // Thêm thông tin vào model
        model.addAttribute("listHoaDon", hoaDons.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hoaDons.getTotalPages());
        model.addAttribute("search", search);  // Thêm search vào model để duy trì tìm kiếm trên các trang phân trang

        return "quanly/hoadon/hoadon";
    }



    @GetMapping("/view/detail/{id}")
    public String detailHoaDon(@PathVariable Long id, Model model){
        HoaDon hoaDon = hoaDonService.findHoaDonById(id);
        model.addAttribute("hoaDon", hoaDon);
        model.addAttribute("listHdct", hoaDonChiTietService.findAllByid(id));
        return "quanly/hoadon/detail";
    }

    //form edit hóa đơn
    @GetMapping("/edit/hoa-don/{id}")
    public String editHoaDon(@PathVariable Long id, Model model){
        model.addAttribute("hoaDon", hoaDonService.findHoaDonById(id));
        model.addAttribute("dsKhachHang", khachHangRepository.findAll());
        model.addAttribute("dsNhanVien", nhanVienRepository.findAll());
        model.addAttribute("dsVoucher", voucherRepository.findAll());
        model.addAttribute("dsPttt", ptttRepository.findAll());

        return "quanly/hoadon/edit-hoa-don";
    }

    // update hoa don
    @PostMapping("/update/hoa-don")
    public String updateHoaDon (@ModelAttribute HoaDon hoaDon){
        hoaDon.setNgaySua(new Date());
        hoaDonService.updateHoaDon(hoaDon);
        return "redirect:/api/quan-ly/hoa-don/view-hoa-don";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }

    // hóa đơn chi tiết

    @GetMapping("view/hoa-don-chi-tiet/{id}")
    public String showDetailHoaDon(@PathVariable Long id , Model model){

        model.addAttribute("hoaDonChiTiet" , hoaDonChiTietService.findHdctByid(id));

        return "quanly/hoadon/detail-hoa-don-chi-tiet";
    }

    @GetMapping("view/san-pham-chi-tiet/{id}")
    public String viewSanPhamChiTiet(@PathVariable Long id, Model model){
        QuanJeansChiTiet quanJeansChiTiet = quanJeansChiTietService.getQuanJeansChiTietById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm chi tiết với ID: " + id));
        model.addAttribute("quanJeansChiTiet", quanJeansChiTiet);
        model.addAttribute("listMauSac", mauSacRepository.findAllByTrangThai(1));
        model.addAttribute("listSize", sizeRepository.findAllByTrangThai(1));
        List<HinhAnh> has = hinhAnhService.getHaByQuanJensAndMauSac(quanJeansChiTiet.getQuanJeans().getId(), quanJeansChiTiet.getMauSac().getId());
        model.addAttribute("listHinhAnh", has);
        return "quanly/hoadon/view-san-pham-chi-tiet";
    }

//    @GetMapping("/hoadon-search")
//    public String searchHoaDond(@RequestParam("search") String search , Model model){
//        model.addAttribute("listHoaDon" , hoaDonService.searchHoaDon(search));
//        return "quanly/hoadon/hoadon";
//    }










}
