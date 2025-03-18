package com.example.demo.controller.online;

import com.example.demo.config.SecurityUtil;
import com.example.demo.entity.HoaDon;
import com.example.demo.repository.HoaDonChiTietRepository;
import com.example.demo.repository.HoaDonRepository;
import com.example.demo.repository.PTTTRepository;
import com.example.demo.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {
    @Autowired
    private VoucherRepository voucherRepository;
    @Autowired
    private PTTTRepository ptttRepository;
    @Autowired
    HoaDonRepository hoaDonRepository;
    @Autowired
    HoaDonChiTietRepository hoaDonChiTietRepository;

    private final SecurityUtil securityUtil;

    public OrderController(SecurityUtil securityUtil) {
        this.securityUtil = securityUtil;
    }

    @GetMapping("order/checkout")
    public String orderCheckout(Model model) {
        model.addAttribute("pttt", ptttRepository.findAll());
        return "online/order/order-checkout";
    }

    @GetMapping("/order-history")
    public String orderDetail(Model model
    ) {
        Long id = securityUtil.getCurrentKhachHang().getId();
            List<HoaDon> hoaDon = hoaDonRepository.getHoaDonByIdKhachHang(id);
        Collections.reverse(hoaDon);
        model.addAttribute("hd", hoaDon);
        return "online/order/order-detail";
    }

    @GetMapping("/order-history/status")
    public String orderDetailByStatus(@RequestParam("status") Integer status, Model model
    ) {
        Long id = securityUtil.getCurrentKhachHang().getId();
        List<HoaDon> hoaDon = hoaDonRepository.getHoaDonByIdKhachHangaAndTrangThai(id, status);
        Collections.reverse(hoaDon);
        model.addAttribute("hd", hoaDon);
        return "online/order/order-detail";
    }

    @GetMapping("order")
    @ResponseBody
    public ResponseEntity<?> getVoucher(@RequestParam("dieuKien") Double dieuKien) {
        return ResponseEntity.ok(Map.of("voucher", voucherRepository.getVoucherByDieuKienApDung(dieuKien)));
    }


    @PostMapping("/insert-bill")
    @ResponseBody
    public ResponseEntity<?> insertBill(
            @RequestParam("sumMoney") Double sumMoney,
            @RequestParam("ship") Double ship,
            @RequestParam("discount") Double discount,
            @RequestParam("money") Double money,
            @RequestParam("address") String address,
            @RequestParam("idUser") Long idUser,
            @RequestParam("idVoucher") Long idVoucher,
            @RequestParam("idPTTT") Long idPTTT
    ) {
        return ResponseEntity.ok(hoaDonRepository.saveHoaDon(sumMoney, ship, discount, money, address, idUser, idVoucher, idPTTT));
    }

    @PostMapping("/insert-bill/isnull")
    @ResponseBody
    public ResponseEntity<?> insertBillIsNull(
            @RequestParam("sumMoney") Double sumMoney,
            @RequestParam("ship") Double ship,
            @RequestParam("discount") Double discount,
            @RequestParam("money") Double money,
            @RequestParam("address") String address,
            @RequestParam("idUser") Long idUser,
            @RequestParam("idPTTT") Long idPTTT
    ) {
        return ResponseEntity.ok(hoaDonRepository.saveHoaDonIsNullVoucher(sumMoney, ship, discount, money, address, idUser, idPTTT));
    }

    @PostMapping("/insert-billDetail")
    @ResponseBody
    public void insertBillDetail(
            @RequestParam("quantity") Integer quantity,
            @RequestParam("price") Double price,
            @RequestParam("sumMoney") Double sumMoney,
            @RequestParam("idHoaDon") Long idHoaDon,
            @RequestParam("idQuanCT") Long idQuanCT
    ) {
        hoaDonChiTietRepository.insertHDCT(quantity, price, sumMoney, idHoaDon, idQuanCT);
    }

    @PutMapping("/update/tt-huy")
    @ResponseBody
    public void updateTTHuy(@RequestParam("id") Long id) {
        hoaDonRepository.updateTrangThaiDaHuy(id);
    }

    @PutMapping("/update/tt-hoanthanh")
    @ResponseBody
    public void updateTTHoanThang(@RequestParam("id") Long id) {
        hoaDonRepository.updateTrangThaiHoanThanh(id);
    }


}

