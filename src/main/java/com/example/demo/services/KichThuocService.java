package com.example.demo.services;

import com.example.demo.entity.Size;
import com.example.demo.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class KichThuocService {

    @Autowired
    private SizeRepository sizeRepository;

    // Lấy tất cả Kích thước
    public List<Size> findAll() {
        return sizeRepository.findAll();
    }

    public List<Size> findAllByTrangThai() {
        return sizeRepository.findAllByTrangThai(1);
    }

    // Lấy Kích thước theo ID
    public Size findById(Long id) {
        Optional<Size> size = sizeRepository.findById(id);
        return size.orElse(null);
    }

    // Lưu hoặc Cập nhật Kích thước
    public Size save(Size size) {
        return sizeRepository.save(size);
    }

    // Cập nhật trạng thái Kích thước thành "Không hoạt động"
    public void deactivate(Long id) {
        Size size = findById(id);
        if (size != null) {
            size.setTrangThai(0);  // Đặt trạng thái thành "Không hoạt động"
            save(size);
        }
    }
}
