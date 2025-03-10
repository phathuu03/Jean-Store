package com.example.demo.services;

import com.example.demo.entity.HoaDon;
import com.example.demo.repository.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HoaDonService {

    @Autowired
    private HoaDonRepository hoaDonRepository;

    public List<HoaDon> getAll(){
        return hoaDonRepository.findAll();
    }


    public HoaDon findHoaDonById(Long id) {
        return hoaDonRepository.findById(id).get();
    }

    public void updateHoaDon(HoaDon hoaDon){
        hoaDonRepository.save(hoaDon);
    }

}
