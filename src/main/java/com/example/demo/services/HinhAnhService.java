package com.example.demo.services;

import com.example.demo.entity.HinhAnh;
import com.example.demo.entity.QuanJeans;
import com.example.demo.repository.HinhAnhRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class HinhAnhService {

    @Autowired
    private HinhAnhRepository hinhAnhRepository;

    // Phương thức để lưu hình ảnh vào cơ sở dữ liệu
    public HinhAnh saveImage(String imageUrl, QuanJeans quanJeans, Long idMauSac) {
        HinhAnh hinhAnh = new HinhAnh();
        hinhAnh.setQuanJeans(quanJeans);
        hinhAnh.setUrl(imageUrl);
        hinhAnh.setNgayTao(new Date());
        hinhAnh.setTrangThai(1);  // Trạng thái mặc định là 1 (hoạt động)
        hinhAnh.setIdMauSac(idMauSac);
        return hinhAnhRepository.save(hinhAnh);
    }

    public List<HinhAnh> getHaByQuanJensAndMauSac(Long idQuanJean, Long idMauSac) {
        return hinhAnhRepository.findHinhAnhByQuanJeansAndIdMauSac(idQuanJean, idMauSac);
    }

    // Phương thức xóa một hình ảnh theo ID
    public void deleteImageById(Long imageId) {
        if (hinhAnhRepository.existsById(imageId)) {
            hinhAnhRepository.deleteById(imageId);
        }
    }

    // Phương thức xóa nhiều hình ảnh theo danh sách ID
    public void deleteImagesByIds(List<Long> imageIds) {
        if (imageIds != null && !imageIds.isEmpty()) {
            imageIds.forEach(id -> {
                if (hinhAnhRepository.existsById(id)) {
                    hinhAnhRepository.deleteById(id);
                }
            });
        }
    }
}
