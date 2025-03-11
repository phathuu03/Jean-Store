package com.example.demo.controller;

import com.example.demo.repository.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Controller
public class ThongKeController {

    @Autowired
    private HoaDonRepository hoaDonRepository;

    @GetMapping("/thong-ke")
    public String viewThongKe(Model model,
                              @RequestParam(value = "year", required = false, defaultValue = "2025") int year) {
        List<Object[]> doanhThuTheoThang = hoaDonRepository.getDoanhThuTheoNam(year);
        int soDonHang = hoaDonRepository.countTatCaDonHangThanhToan();

        List<Integer> doanhThuThang = new ArrayList<>(Collections.nCopies(12, 0));
        for (Object[] obj : doanhThuTheoThang) {
            if (obj.length < 2 || obj[0] == null || obj[1] == null) continue;
            int thang = ((Number) obj[0]).intValue();
            int tongTien = ((Number) obj[1]).intValue();
            if (thang >= 1 && thang <= 12) {
                doanhThuThang.set(thang - 1, tongTien);
            }
        }

        int tongDoanhThu = hoaDonRepository.tinhTongDoanhThu();

        // 🔥 Tạo phí ship random từng tháng
        List<Integer> phiShipThang = new ArrayList<>(Collections.nCopies(12, 0));
        for (int i = 0; i < 12; i++) {
            if (doanhThuThang.get(i) > 0) {
                phiShipThang.set(i, ThreadLocalRandom.current().nextInt(50000, 101000));
            }
        }

        int tongPhiShip = phiShipThang.stream().mapToInt(Integer::intValue).sum();
        int tongDoanhThuThucTe = tongDoanhThu - tongPhiShip;

        // 🔥 Thêm logic lấy doanh thu các năm
        List<Integer> doanhThuNam = new ArrayList<>(Collections.nCopies(3, 0));
        List<Object[]> doanhThuData = hoaDonRepository.getDoanhThuCacNam();
        for (Object[] row : doanhThuData) {
            if (row.length < 2 || row[0] == null || row[1] == null) continue;
            int yearData = ((Number) row[0]).intValue();
            int tongDoanhThuNam = ((Number) row[1]).intValue();
            if (yearData >= 2023 && yearData <= 2025) {
                int index = 2025 - yearData;
                doanhThuNam.set(index, tongDoanhThuNam);
            }
        }

        model.addAttribute("doanhThuThang", doanhThuThang);
        model.addAttribute("tongDoanhThu", tongDoanhThu);
        model.addAttribute("tongDoanhThuThucTe", tongDoanhThuThucTe);
        model.addAttribute("tongPhiShip", tongPhiShip);
        model.addAttribute("soDonHang", soDonHang);
        model.addAttribute("phiShipThang", phiShipThang);
        model.addAttribute("selectedYear", year);
        model.addAttribute("doanhThuNam", doanhThuNam);

        return "quanly/thongke/thongke";
    }

    // 📌 API lấy dữ liệu doanh thu theo tháng (JSON)
    @GetMapping("/api/doanh-thu")
    @ResponseBody
    public List<Integer> getDoanhThu(@RequestParam(value = "year", required = false, defaultValue = "2025") int year) {
        List<Object[]> doanhThuTheoThang = hoaDonRepository.getDoanhThuTheoNam(year);
        List<Integer> doanhThuThang = new ArrayList<>(Collections.nCopies(12, 0));

        for (Object[] obj : doanhThuTheoThang) {
            if (obj.length < 2 || obj[0] == null || obj[1] == null) continue;
            int thang = ((Number) obj[0]).intValue();
            int tongTien = ((Number) obj[1]).intValue();
            if (thang >= 1 && thang <= 12) {
                doanhThuThang.set(thang - 1, tongTien);
            }
        }
        return doanhThuThang;
    }

    // 📌 API lấy doanh thu theo năm (JSON)
    @GetMapping("/api/doanh-thu-nam")
    @ResponseBody
    public List<Integer> getDoanhThuNam() {
        List<Integer> doanhThuNam = new ArrayList<>(Collections.nCopies(3, 0)); // Mặc định 3 năm: 2023, 2024, 2025
        List<Object[]> doanhThuData = hoaDonRepository.getDoanhThuCacNam();

        for (Object[] row : doanhThuData) {
            if (row.length < 2 || row[0] == null || row[1] == null) continue;
            int year = ((Number) row[0]).intValue();
            int tongDoanhThu = ((Number) row[1]).intValue();
            if (year >= 2023 && year <= 2025) {
                int index = 2025 - year;
                doanhThuNam.set(index, tongDoanhThu);
            }
        }
        return doanhThuNam;
    }
}
