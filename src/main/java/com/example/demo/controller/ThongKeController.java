package com.example.demo.controller;

import com.example.demo.repository.HoaDonRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
public class ThongKeController {

    private static final Logger logger = LoggerFactory.getLogger(ThongKeController.class);

    @Autowired
    private HoaDonRepository hoaDonRepository;

    @GetMapping("/thong-ke")
    public String viewThongKe(Model model,
                              @RequestParam(value = "year", required = false, defaultValue = "2025") int year) {
        List<Object[]> doanhThuTheoThang = hoaDonRepository.getDoanhThuTheoNam(year);
        int soDonHang = hoaDonRepository.countTatCaDonHangThanhToan();

        List<Long> doanhThuThang = new ArrayList<>(Collections.nCopies(12, 0L));
        List<Long> phiShipThang = new ArrayList<>(Collections.nCopies(12, 0L));
        List<Long> giamGiaThang = new ArrayList<>(Collections.nCopies(12, 0L));

        for (Object[] obj : doanhThuTheoThang) {
            if (obj.length < 4 || obj[0] == null || obj[1] == null || obj[2] == null || obj[3] == null) continue;

            int thang = ((Number) obj[0]).intValue();
            long tongTien = ((Number) obj[1]).longValue();
            long phiShip = ((Number) obj[2]).longValue();
            long giamGia = ((Number) obj[3]).longValue();

            if (thang >= 1 && thang <= 12) {
                doanhThuThang.set(thang - 1, tongTien);
                phiShipThang.set(thang - 1, phiShip);
                giamGiaThang.set(thang - 1, giamGia);
            }
        }

        long tongDoanhThu = hoaDonRepository.getDoanhThuCacNam().stream()
                .mapToLong(row -> ((Number) row[1]).longValue())
                .sum();
        long tongPhiShip = hoaDonRepository.getTongPhiShip();
        long tongGiamGia = hoaDonRepository.getTongGiamGia();
        long tongDoanhThuThucTe = Math.max(0, tongDoanhThu - tongPhiShip);

        List<Integer> doanhThuNam = new ArrayList<>(Collections.nCopies(3, 0));
        List<Object[]> doanhThuData = hoaDonRepository.getDoanhThuCacNam();

        for (Object[] row : doanhThuData) {
            if (row.length < 2 || row[0] == null || row[1] == null) continue;

            int yearData = ((Number) row[0]).intValue();
            int tongDoanhThuNam = ((Number) row[1]).intValue();

            if (yearData >= 2023 && yearData <= 2025) {
                int index = yearData - 2023;
                doanhThuNam.set(index, tongDoanhThuNam);
            }
        }

        logger.info("✅ Doanh thu từng năm: {}", doanhThuNam);
        logger.info("🚚 Tổng phí ship: {}", tongPhiShip);
        logger.info("🎯 Tổng giảm giá: {}", tongGiamGia);

        model.addAttribute("doanhThuThang", doanhThuThang);
        model.addAttribute("tongDoanhThu", tongDoanhThu);
        model.addAttribute("tongDoanhThuThucTe", tongDoanhThuThucTe);
        model.addAttribute("tongPhiShip", tongPhiShip);
        model.addAttribute("tongGiamGia", tongGiamGia);
        model.addAttribute("soDonHang", soDonHang);
        model.addAttribute("phiShipThang", phiShipThang);
        model.addAttribute("giamGiaThang", giamGiaThang);
        model.addAttribute("selectedYear", year);
        model.addAttribute("doanhThuNam", doanhThuNam);

        return "quanly/thongke/thongke";
    }

    @GetMapping("/api/doanh-thu")
    @ResponseBody
    public List<Long> getDoanhThu(@RequestParam(value = "year", required = false, defaultValue = "2025") int year) {
        List<Object[]> doanhThuTheoThang = hoaDonRepository.getDoanhThuTheoNam(year);
        List<Long> doanhThuThang = new ArrayList<>(Collections.nCopies(12, 0L));

        for (Object[] obj : doanhThuTheoThang) {
            if (obj.length < 2 || obj[0] == null || obj[1] == null) continue;
            int thang = ((Number) obj[0]).intValue();
            long tongTien = ((Number) obj[1]).longValue();
            if (thang >= 1 && thang <= 12) {
                doanhThuThang.set(thang - 1, tongTien);
            }
        }
        return doanhThuThang;
    }
}
