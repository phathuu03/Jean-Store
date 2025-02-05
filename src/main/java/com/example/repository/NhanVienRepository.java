package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.NhanVien;

@Repository
public interface NhanVienRepository extends JpaRepository<NhanVien, Long> {
}
