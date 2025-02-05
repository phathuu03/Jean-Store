package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.HoaDonChiTiet;

@Repository
public interface HoaDonChiTietRepository extends JpaRepository<HoaDonChiTiet, Long> {
}
