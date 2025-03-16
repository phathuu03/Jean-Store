package com.example.demo.services;

import com.example.demo.entity.Size;
import com.example.demo.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class KichThuocService {

    @Autowired
    private SizeRepository sizeRepository;

    // Lấy tất cả Kích thước
    public Page<Size> findAll(Pageable pageable) {
        return sizeRepository.findAll(pageable);
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
        size.setNgayTao(new Date());
        return sizeRepository.save(size);
    }

    // Cập nhật trạng thái Kích thước thành "Không hoạt động"
    public void deactivate(Long id) {
        Size size = findById(id);
        if (size != null) {

            if(size.getTrangThai() == 0){
                size.setNgaySua(new Date());
                size.setTrangThai(1);  // Đặt trạng thái thành "Không hoạt động"
                save(size);
            }else {
                size.setNgaySua(new Date());
                size.setTrangThai(0);  // Đặt trạng thái thành "Không hoạt động"
                save(size);
            }
        }
    }
}
