package com.example.demo.controller.online;

import com.example.demo.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class VoucherRestController {
    @Autowired
    private VoucherRepository voucherRepository;
    @PutMapping("/update-quantity/voucher")
    public ResponseEntity<?> updateQuantity(@RequestParam("id") Long id) {
        voucherRepository.updateSoLuong(id);
        return ResponseEntity.ok("Cập nhật thành công");
    }
}
