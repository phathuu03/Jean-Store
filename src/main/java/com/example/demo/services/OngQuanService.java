package com.example.demo.services;

import com.example.demo.entity.OngQuan;
import com.example.demo.repository.OngQuanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OngQuanService {

    @Autowired
    private OngQuanRepository ongQuanRepository;

    public List<OngQuan> getAllOngQuan() {
        return ongQuanRepository.findAll();
    }
    public List<OngQuan> getAllActiveOngQuan(){
        return ongQuanRepository.findAllByTrangThai(1);
    }

    public OngQuan saveOngQuan(OngQuan ongQuan) {
        return ongQuanRepository.save(ongQuan);
    }

    public void deleteOngQuan(Long id) {
        OngQuan ongQuan = ongQuanRepository.findById(id).orElseThrow();
        ongQuan.setTrangThai(0); // Đổi trạng thái thành không hoạt động
        ongQuanRepository.save(ongQuan);
    }

    // Lấy Loại Ống Quần theo ID
    public OngQuan getOngQuanById(Long id) {
        return ongQuanRepository.findById(id).orElseThrow(() -> new RuntimeException("Loại Ống Quần không tồn tại"));
    }


}
