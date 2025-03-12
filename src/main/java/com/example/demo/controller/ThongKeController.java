package com.example.demo.controller;

import com.example.demo.repository.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

//@Controller
//public class ThongKeController {
//
//    @Autowired
//    private HoaDonRepository hoaDonRepository;
//
//    @GetMapping("/thong-ke")
//    public String viewThongKe(Model model,
//                              @RequestParam(value = "year", required = false, defaultValue = "2025") int year) {
//        // Lấy danh sách doanh thu theo tháng
//        List<Object[]> doanhThuTheoThang = hoaDonRepository.getDoanhThuTheoNam(year);
//        int soDonHang = hoaDonRepository.countSoDonHang(year); // Lấy số đơn hàng theo năm
//
//        // Kiểm tra dữ liệu từ database
//        System.out.println("Dữ liệu từ DB:");
//        for (Object[] obj : doanhThuTheoThang) {
//            System.out.println("Tháng: " + obj[0] + ", Tổng Tiền: " + obj[1]);
//        }
//
//        // Danh sách mặc định với 12 tháng có giá trị 0
//        List<Integer> doanhThuThang = new ArrayList<>(Collections.nCopies(12, 0));
//
//        for (Object[] obj : doanhThuTheoThang) {
//            if (obj.length < 2 || obj[0] == null || obj[1] == null) {
//                System.out.println("Lỗi dữ liệu: " + Arrays.toString(obj));
//                continue; // Bỏ qua nếu dữ liệu không đủ hoặc null
//            }
//
//            int thang = ((Number) obj[0]).intValue(); // Lấy tháng từ DB
//            int tongTien = ((Number) obj[1]).intValue(); // Lấy doanh thu của tháng đó
//
//            if (thang >= 1 && thang <= 12) { // Chỉ gán nếu tháng hợp lệ
//                doanhThuThang.set(thang - 1, tongTien);
//            } else {
//                System.out.println("Lỗi: Tháng không hợp lệ - " + thang);
//            }
//        }
//
//        // Tính tổng doanh thu
//        int tongDoanhThu = doanhThuThang.stream().mapToInt(Integer::intValue).sum();
//        int tongPhiShip = soDonHang * 35000;
//        int tongDoanhThuThucTe = tongDoanhThu - tongPhiShip;
//
//        model.addAttribute("doanhThuThang", doanhThuThang);
//        model.addAttribute("tongDoanhThu", tongDoanhThu);
//        model.addAttribute("tongDoanhThuThucTe", tongDoanhThuThucTe);
//        model.addAttribute("tongPhiShip", tongPhiShip);
//        model.addAttribute("soDonHang", soDonHang);
//        model.addAttribute("selectedYear", year);
//
//        System.out.println("Tổng doanh thu: " + tongDoanhThu);
//        System.out.println("Tổng phí ship: " + tongPhiShip);
//        System.out.println("Tổng doanh thu thực tế: " + tongDoanhThuThucTe);
//
//        return "quanly/thongke/thongke";
//    }
//}
