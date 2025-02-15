package com.example.demo.controller.online;

import com.example.demo.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class OrderController {
    @Autowired
    private VoucherRepository voucherRepository;

    @GetMapping("order/checkout")
    public String orderDetail() {
        return "online/order/order-checkout";
    }

    @GetMapping("order")
    @ResponseBody
    public ResponseEntity<?> getVoucher(@RequestParam("dieuKien") Double dieuKien) {
        return ResponseEntity.ok(Map.of("voucher", voucherRepository.getVoucherByDieuKienApDung(dieuKien)));
    }
}

