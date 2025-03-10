package com.example.demo.repository;

import com.example.demo.entity.GioHangChiTietDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GioHangChiTietDTORepository extends JpaRepository<GioHangChiTietDTO, Long> {
    List<GioHangChiTietDTO> findGioHangChiTietByKhachHang_Id(@Param("id") Long id);
}
