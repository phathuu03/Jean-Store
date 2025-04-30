package com.example.demo.services;


import com.example.demo.entity.QuanJeans;
import com.example.demo.entity.Size;
import com.example.demo.repository.QuanJeansRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class QuanJeanService {

    @Autowired
    private QuanJeansRepository quanJeansRepository;

    // Phương thức lấy tất cả sản phẩm với phân trang và đảo ngược thứ tự
    public Page<QuanJeans> getAllQuanJean(Pageable pageable) {
        // Lấy tất cả sản phẩm
        List<QuanJeans> allQuanJeans = quanJeansRepository.findAll();

        // Đảo ngược thứ tự danh sách
        Collections.reverse(allQuanJeans);

        // Tính toán phạm vi phân trang
        int start = pageable.getPageNumber() * pageable.getPageSize();
        int end = Math.min((start + pageable.getPageSize()), allQuanJeans.size());

        // Lấy danh sách đã phân trang từ danh sách đã đảo ngược
        List<QuanJeans> paginatedQuanJeans = allQuanJeans.subList(start, end);

        // Tạo Page từ danh sách đã phân trang
        return new PageImpl<>(paginatedQuanJeans, pageable, allQuanJeans.size());
    }
    public Page<QuanJeans> getAllQuanJean(String search, Pageable pageable) {
        if (search == null || search.isEmpty()) {
            // Nếu không có từ khóa tìm kiếm, trả về tất cả các sản phẩm
            return quanJeansRepository.findAll(pageable);
        } else {
            // Nếu có từ khóa tìm kiếm, tìm kiếm theo tên sản phẩm
            return quanJeansRepository.findByTenSanPhamOrMaSanPhamContainingIgnoreCase(search , pageable);
        }
    }

    public List<QuanJeans> getAllQuanJean() {
        return quanJeansRepository.findAll();
    }

    public QuanJeans saveQuanJean(QuanJeans quanJeans) {
        return quanJeansRepository.save(quanJeans);
    }

    public void deleteQuanJean(Long id) {
        QuanJeans quanJeans = quanJeansRepository.findById(id).get();
        if (quanJeans != null) {
            if(quanJeans.getTrangThai() == 0){
                quanJeans.setTrangThai(1);
            }else {
                quanJeans.setTrangThai(0);
            }
             // Đặt trạng thái thành "Không hoạt động"
            quanJeans.setNgaySua(LocalDate.now());
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
