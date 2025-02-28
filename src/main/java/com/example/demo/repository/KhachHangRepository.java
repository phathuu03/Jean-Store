package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.KhachHang;

@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang, Long> {
    KhachHang findByEmailAndMatKhau(String email, String matKhau);
    KhachHang findByEmail(String email);

}
