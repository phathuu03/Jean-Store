package com.example.demo.controller.online;

import com.example.demo.config.SecurityUtil;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserOnlController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    private final SecurityUtil securityUtil;

    public UserOnlController(SecurityUtil securityUtil) {
        this.securityUtil = securityUtil;
    }

    @GetMapping("/id")
    public ResponseEntity<?> getCurrentUserId() {
        KhachHang khachHang = securityUtil.getCurrentKhachHang();
        if (khachHang == null) {
            return ResponseEntity.ok("Khach Hang is null");
        }
        return ResponseEntity.ok(Map.of("id", khachHang.getId()));
    }

    @GetMapping("")
    public ResponseEntity<?> getUserById(@RequestParam("id") Long id) {
        return ResponseEntity.ok(Map.of("khachHang", khachHangRepository.getKhachHangById(id)));
    }

    @PutMapping("/update")
    public ResponseEntity<?> updateUser(@RequestParam("gender") Boolean gender,
                                        @RequestParam("name") String name,
                                        @RequestParam("email") String email
    ) {
        KhachHang khachHang = securityUtil.getCurrentKhachHang();
        if (khachHang == null) {
            return ResponseEntity.ok("Khach Hang is null");
        }
        khachHangRepository.updateKhachHang(gender, name, email, khachHang.getId());
        return ResponseEntity.ok(Map.of("alert", "Cập nhật thành công"));
    }

    @PutMapping("/update/password")
    public ResponseEntity<?> updatePasswordUser(@RequestParam("password") String password
    ) {
        KhachHang khachHang = securityUtil.getCurrentKhachHang();
        if (khachHang == null) {
            return ResponseEntity.ok("Khach Hang is null");
        }
        khachHangRepository.updatePassword(password, khachHang.getId());
        return ResponseEntity.ok(Map.of("mes", "Cập nhật thành công"));
    }

    @GetMapping("/insert")
    public ResponseEntity<?> insertUser(
            @RequestParam("name") String name,
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("sdt") String sdt,
            @RequestParam("email") String email,
            @RequestParam("gender") Boolean gender
    ) {
        List<KhachHang> khachHangList = khachHangRepository.findAll();
        boolean checkUsername = false;

        for (KhachHang khachHang : khachHangList) {
            if (khachHang.getTenDangNhap().equals(username)) {
                checkUsername = true;
            }
        }
        if (checkUsername) {
            return ResponseEntity.ok(Map.of("check", 10000));
        } else {
            khachHangRepository.insertUser(name, username, password, sdt, email, gender);
            return ResponseEntity.ok(Map.of("check", 5000));
        }
    }

    @GetMapping("/update/address")
    public ResponseEntity<?> updateAddress(@RequestParam("provinces") String provinces,
                                           @RequestParam("districts") String districts,
                                           @RequestParam("wards") String wards,
                                           @RequestParam("address") String address

    ) {
        KhachHang khachHang = securityUtil.getCurrentKhachHang();
        if (khachHang == null) {
            return ResponseEntity.ok(Map.of("mes", "ID Khach Hang is null"));
        }
        khachHangRepository.updateAddress(provinces, districts, wards, address, khachHang.getId());
        return ResponseEntity.ok(Map.of("mes", "OK"));
    }

}
