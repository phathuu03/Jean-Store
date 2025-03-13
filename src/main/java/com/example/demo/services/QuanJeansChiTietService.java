package com.example.demo.services;

import com.example.demo.entity.QuanJeansChiTiet;
import com.example.demo.repository.QuanJeansChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class QuanJeansChiTietService {

    @Autowired
    private QuanJeansChiTietRepository repository;

    public List<QuanJeansChiTiet> getAllByQuanJeansId(Long quanJeansId) {
        return repository.findQuanJeansChiTietsById(quanJeansId);
    }

    // Lấy tất cả sản phẩm chi tiết
    public List<QuanJeansChiTiet> getAllQuanJeansChiTiet() {
        return repository.findAll();
    }


    // Lấy sản phẩm chi tiết theo ID
    public Optional<QuanJeansChiTiet> getQuanJeansChiTietById(Long id) {
        return repository.findById(id);
    }

    // Thêm mới sản phẩm chi tiết
    public QuanJeansChiTiet addQuanJeansChiTiet(QuanJeansChiTiet quanJeansChiTiet) {
        return repository.save(quanJeansChiTiet);
    }

    // Cập nhật sản phẩm chi tiết
    public QuanJeansChiTiet updateQuanJeansChiTiet(Long id, QuanJeansChiTiet updatedQuanJeansChiTiet) {
        return repository.findById(id).map(qjct -> {
            qjct.setMoTa(updatedQuanJeansChiTiet.getMoTa());
            qjct.setGia(updatedQuanJeansChiTiet.getGia());
            qjct.setSoLuong(updatedQuanJeansChiTiet.getSoLuong());
            qjct.setTrangThai(updatedQuanJeansChiTiet.getTrangThai());
            qjct.setMauSac(updatedQuanJeansChiTiet.getMauSac());
            qjct.setSize(updatedQuanJeansChiTiet.getSize());
            qjct.setQuanJeans(updatedQuanJeansChiTiet.getQuanJeans());
            return repository.save(qjct);
        }).orElseThrow(() -> new RuntimeException("Không tìm thấy QuanJeansChiTiet với ID: " + id));
    }

    // Xóa sản phẩm chi tiết
    public void deleteQuanJeansChiTiet(Long id) {
        QuanJeansChiTiet quanJeansChiTiet = repository.findById(id).get();
        if (quanJeansChiTiet != null) {
            if (quanJeansChiTiet.getTrangThai() == 0) {
                quanJeansChiTiet.setTrangThai(1);
            } else {
                quanJeansChiTiet.setTrangThai(0);
            }

            repository.save(quanJeansChiTiet);
        }
    }

    public boolean existsQuanJeansChiTiet(Long quanJeansId, Long mauSacId, Long sizeId) {
        return repository.existsByQuanJeansIdAndMauSacIdAndSizeId(quanJeansId, mauSacId, sizeId);
    }


}
