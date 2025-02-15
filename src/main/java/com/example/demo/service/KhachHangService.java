package com.example.demo.service;


import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepository khachHangRepository;

    public List<KhachHang> getAllKhachHang() {
        List<KhachHang> khachHangs = new ArrayList<>();
        khachHangs = khachHangRepository.findAll();
        return khachHangs;
    }
    public KhachHang findByTenDangNhap(String tenDangNhap) {
        return khachHangRepository.findIdByTenDangNhap(tenDangNhap);
    }
}
