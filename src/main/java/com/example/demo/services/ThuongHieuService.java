package com.example.demo.services;

import com.example.demo.entity.ChatLieu;
import com.example.demo.entity.ThuongHieu;
import com.example.demo.repository.ThuongHieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ThuongHieuService {
    @Autowired
    private ThuongHieuRepository thuongHieuRepository;

    public List<ThuongHieu> getAllThuongHieu(){
        return thuongHieuRepository.findAll();
    }
    public ThuongHieu saveThuongHieu(ThuongHieu thuongHieu) {

        thuongHieu.setNgayTao(new Date());
        return thuongHieuRepository.save(thuongHieu);
    }
    public Boolean existsThuongHieu(String tenThuongHieu){
        return thuongHieuRepository.existsChatLieuByTenThuongHieu(tenThuongHieu);
    }

    public List<ThuongHieu> getAllActiveThuongHieu() {
        return thuongHieuRepository.findAllByTrangThai(1);
    }

    public Page<ThuongHieu> getAllThuongHieu(Pageable pageable) {
        return thuongHieuRepository.findAll(pageable);
    }
    public void deleteThuongHieu(Long id) {
        ThuongHieu thuongHieu = thuongHieuRepository.findById(id).orElseThrow();
        if(thuongHieu.getTrangThai() == 0){
            thuongHieu.setNgaySua(new Date());
            thuongHieu.setTrangThai(1); // Đổi trạng thái thành không hoạt động
            thuongHieuRepository.save(thuongHieu);
        }else {
            thuongHieu.setNgaySua(new Date());
            thuongHieu.setTrangThai(0); // Đổi trạng thái thành không hoạt động
            thuongHieuRepository.save(thuongHieu);
        }
    }
    // Lấy Thương Hiệu theo ID
    public ThuongHieu getThuongHieuById(Long id) {
        return thuongHieuRepository.findById(id).orElseThrow(() -> new RuntimeException("Thương Hiệu không tồn tại"));
    }

}
