package com.example.demo.services;

import com.example.demo.entity.ChatLieu;
import com.example.demo.entity.OngQuan;
import com.example.demo.repository.OngQuanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class OngQuanService {

    @Autowired
    private OngQuanRepository ongQuanRepository;

    public List<OngQuan> getAllOngQuan() {
        return ongQuanRepository.findAll();
    }

    public List<OngQuan> getAllActiveOngQuan() {
        return ongQuanRepository.findAllByTrangThai(1);
    }

    public OngQuan saveOngQuan(OngQuan ongQuan) {

        ongQuan.setNgayTao(new Date());
        return ongQuanRepository.save(ongQuan);
    }

    public Page<OngQuan> getAllOngQuan(Pageable pageable) {
        return ongQuanRepository.findAll(pageable);
    }

    public void deleteOngQuan(Long id) {
        OngQuan ongQuan = ongQuanRepository.findById(id).orElseThrow();
        if (ongQuan.getTrangThai() == 0) {
            ongQuan.setNgaySua(new Date());
            ongQuan.setTrangThai(1); // Đổi trạng thái thành không hoạt động
            ongQuanRepository.save(ongQuan);
        } else {
            ongQuan.setNgaySua(new Date());
            ongQuan.setTrangThai(0); // Đổi trạng thái thành không hoạt động
            ongQuanRepository.save(ongQuan);
        }
    }

    // Lấy Loại Ống Quần theo ID
    public OngQuan getOngQuanById(Long id) {
        return ongQuanRepository.findById(id).orElseThrow(() -> new RuntimeException("Loại Ống Quần không tồn tại"));
    }


}
