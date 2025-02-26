package com.example.demo.services;


import com.example.demo.entity.QuanJeans;
import com.example.demo.entity.Size;
import com.example.demo.repository.QuanJeansRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class QuanJeanService {

    @Autowired
    private QuanJeansRepository quanJeansRepository;

    public List<QuanJeans> getAllQuanJean() {
        return quanJeansRepository.findAll();
    }

    public QuanJeans saveQuanJean(QuanJeans quanJeans) {
        return quanJeansRepository.save(quanJeans);
    }

    public void deleteQuanJean(Long id) {
        QuanJeans quanJeans = quanJeansRepository.findById(id).get();
        if (quanJeans != null) {
            quanJeans.setTrangThai(0);  // Đặt trạng thái thành "Không hoạt động"
            quanJeansRepository.save(quanJeans);
        }
    }


    public Optional<QuanJeans> getQuanJeanById(Long id) {
        return quanJeansRepository.findById(id);
    }

    public QuanJeans updateQuanJean(Long id, QuanJeans quanJeans) {
        if (quanJeansRepository.existsById(id)) {
            quanJeans.setId(id); // Đảm bảo ID không bị thay đổi
            return quanJeansRepository.save(quanJeans); // Cập nhật dữ liệu
        } else {
            throw new RuntimeException("Không tìm thấy sản phẩm có ID: " + id);
        }
    }

    public List<QuanJeans> searchQuanJean(String nameQuanJean) {
        return quanJeansRepository.findByTenSanPhamContainingIgnoreCase(nameQuanJean);
    }

}
