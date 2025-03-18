package com.example.demo.services;

import com.example.demo.entity.HoaDon;
import com.example.demo.repository.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HoaDonService {

    @Autowired
    private HoaDonRepository hoaDonRepository;

    public Page<HoaDon> getAll(Pageable pageable) {
        return hoaDonRepository.findAll(pageable);
    }

    public List<HoaDon> getAllHd(){
        return hoaDonRepository.findAll();
    }

    // Phương thức tìm kiếm hóa đơn với phân trang
    public Page<HoaDon> searchHoaDon(String search, Pageable pageable) {
        return hoaDonRepository.searchHoaDon(search, pageable);
    }

    public Page<HoaDon> getHoaDonByStatus(int status, Pageable pageable) {
        return hoaDonRepository.findByTrangThai(status, pageable);
    }

    public HoaDon findHoaDonById(Long id) {
        return hoaDonRepository.findById(id).get();
    }

    public void updateHoaDon(HoaDon hoaDon){
        hoaDonRepository.save(hoaDon);
    }

    public Page<HoaDon> getAllHoaDon (Pageable pageable) { return hoaDonRepository.findAll(pageable);}

    public Boolean xacNhanTrangThai(Long idHoaDon)  {
       HoaDon hd = findHoaDonById(idHoaDon);
       if(hd!= null){
           hd.setTrangThai(1);
           updateHoaDon(hd);
           return true;
       }
       return  false;

    }

    public Boolean huyDonHang(Long idHoaDon)  {
       HoaDon hd = findHoaDonById(idHoaDon);
       if(hd!= null){
           hd.setTrangThai(4);
           updateHoaDon(hd);
           return true;
       }
       return  false;

    }

    public Boolean xnvc(Long idHoaDon)  {
       HoaDon hd = findHoaDonById(idHoaDon);
       if(hd!= null){
           hd.setTrangThai(2);
           updateHoaDon(hd);
           return true;
       }
       return  false;

    }
}
