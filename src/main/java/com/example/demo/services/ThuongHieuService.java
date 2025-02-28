package com.example.demo.services;

import com.example.demo.entity.ChatLieu;
import com.example.demo.entity.ThuongHieu;
import com.example.demo.repository.ThuongHieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThuongHieuService {
    @Autowired
    private ThuongHieuRepository thuongHieuRepository;

    public List<ThuongHieu> getAllThuongHieu(){
        return thuongHieuRepository.findAll();
    }
    public ThuongHieu saveThuongHieu(ThuongHieu thuongHieu) {
        return thuongHieuRepository.save(thuongHieu);
    }
    public List<ThuongHieu> getAllActiveThuongHieu() {
        return thuongHieuRepository.findAllByTrangThai(1);
    }

    public Page<ThuongHieu> getAllThuongHieu(Pageable pageable) {
        return thuongHieuRepository.findAll(pageable);
    }
    public void deleteThuongHieu(Long id) {
        ThuongHieu thuongHieu = thuongHieuRepository.findById(id).orElseThrow();
        thuongHieu.setTrangThai(0); // Đổi trạng thái thành không hoạt động
        thuongHieuRepository.save(thuongHieu);
    }
    // Lấy Thương Hiệu theo ID
    public ThuongHieu getThuongHieuById(Long id) {
        return thuongHieuRepository.findById(id).orElseThrow(() -> new RuntimeException("Thương Hiệu không tồn tại"));
    }

}
