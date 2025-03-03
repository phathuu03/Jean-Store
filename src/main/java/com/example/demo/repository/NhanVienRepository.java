package com.example.demo.repository;

import com.example.demo.entity.NhanVien;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NhanVienRepository extends JpaRepository<NhanVien, Long> {
    List<NhanVien> findByTenNhanVienContaining(String tenNhanVien);
    boolean existsByTenDangNhap(String tenDangNhap);
    NhanVien findByEmail(String email);

}
