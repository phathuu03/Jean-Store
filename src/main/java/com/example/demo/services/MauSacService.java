package com.example.demo.services;

import com.example.demo.entity.MauSac;
import com.example.demo.repository.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class MauSacService {

    @Autowired
    private MauSacRepository mauSacRepository;

    // Lấy tất cả Màu sắc
    public Page<MauSac> findAll(Pageable pageable) {
        return mauSacRepository.findAll(pageable);
    }

    public List<MauSac> findAllByTrangThai() { return mauSacRepository.findAllByTrangThai(1);
    }



    // Lấy Màu sắc theo ID
    public MauSac findById(Long id) {
        Optional<MauSac> mauSac = mauSacRepository.findById(id);
        return mauSac.orElse(null);
    }

    // Lưu hoặc Cập nhật Màu sắc
    public MauSac save(MauSac mauSac) {

        mauSac.setNgayTao(new Date());
        return mauSacRepository.save(mauSac);
    }

    // Cập nhật trạng thái Màu sắc thành "Không hoạt động"
    public void deactivate(Long id) {
        MauSac mauSac = findById(id);
        if (mauSac != null) {
            if(mauSac.getTrangThai() == 0){
                mauSac.setNgaySua(new Date());
                mauSac.setTrangThai(1);  // Đặt trạng thái thành "Không hoạt động"
                save(mauSac);
            }else {
                mauSac.setNgaySua(new Date());
                mauSac.setTrangThai(0);  // Đặt trạng thái thành "Không hoạt động"
                save(mauSac);
            }

        }
    }
}
