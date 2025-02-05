package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.QuanJeansChiTiet;

@Repository
public interface QuanJeansChiTietRepository extends JpaRepository<QuanJeansChiTiet, Long> {
}
