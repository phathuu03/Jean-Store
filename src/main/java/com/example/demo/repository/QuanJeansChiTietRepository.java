package com.example.demo.repository;

import com.example.demo.entity.QuanJeansChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface QuanJeansChiTietRepository extends JpaRepository<QuanJeansChiTiet, Long> {

}
