package com.example.demo.services;

import com.example.demo.entity.HinhAnh;
import com.example.demo.entity.QuanJeans;
import com.example.demo.repository.HinhAnhRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class HinhAnhService {

    @Autowired
    private HinhAnhRepository hinhAnhRepository;

    // Phương thức để lưu hình ảnh vào cơ sở dữ liệu
    public HinhAnh saveImage(String imageUrl, QuanJeans quanJeans) {
        // Tạo đối tượng HinhAnh mới
        HinhAnh hinhAnh = new HinhAnh();

        // Thiết lập các thuộc tính cho hình ảnh
        hinhAnh.setQuanJeans(quanJeans);  // Liên kết hình ảnh với quần jeans
        hinhAnh.setUrl(imageUrl);  // Lưu URL của hình ảnh
        hinhAnh.setNgayTao(new Date());  // Gán thời gian tạo cho hình ảnh
        hinhAnh.setTrangThai(1);  // Trạng thái mặc định là 1 (hoạt động)

        // Lưu đối tượng HinhAnh vào cơ sở dữ liệu và trả về kết quả
        return hinhAnhRepository.save(hinhAnh);
    }
}
