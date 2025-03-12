package com.example.demo.controller.online;


import com.example.demo.repository.QuanJeansChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class QuanJeansChiTietRestController {
    @Autowired
    private QuanJeansChiTietRepository quanJeansChiTietRepository;

    @PutMapping("/update-quantity")
    public ResponseEntity<?> updateQuantity(@RequestParam("id") Long id,@RequestParam("quantity") Integer quantity) {
        quanJeansChiTietRepository.updateSoLuong(quantity,id);
        return ResponseEntity.ok("Cập nhật thành công");
    }
    @GetMapping("/getPrice")
    public ResponseEntity<?> getPrice(@RequestParam("id") Long id){
        return ResponseEntity.ok(quanJeansChiTietRepository.getPirce(id));
    }
}
