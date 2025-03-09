package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.HoaDonChiTiet;

import java.util.List;

@Repository
public interface HoaDonChiTietRepository extends JpaRepository<HoaDonChiTiet, Long> {
    @Query("select hdct from HoaDonChiTiet  hdct where hdct.hoaDon.id = :idHoaDon")
    List<HoaDonChiTiet> findAllByIdHoaDon(@Param("idHoaDon") Long idHoaDon);
}
