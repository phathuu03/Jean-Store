package com.example.demo.services;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.repository.HoaDonChiTietRepository;
import jakarta.validation.constraints.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HoaDonChiTietService {
    @Autowired
    private HoaDonChiTietRepository hoaDonChiTietRepository;

    public List<HoaDonChiTiet> findAllByid(Long idHoaDon) {
        return hoaDonChiTietRepository.findAllByIdHoaDon(idHoaDon);
    }

    public HoaDonChiTiet findHdctByid(Long id){
        return hoaDonChiTietRepository.findById(id).get();
    }
}
