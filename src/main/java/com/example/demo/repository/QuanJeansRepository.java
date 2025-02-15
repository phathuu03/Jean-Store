package com.example.demo.repository;

import com.example.demo.dto.QuanJeansHinhAnhDto;
import com.example.demo.entity.QuanJeans;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuanJeansRepository extends JpaRepository<QuanJeans, Long> {

    @Query(value = "select TenSanPham from QuanJeans where ID = :id",nativeQuery = true)
    String getNameProduct(@Param("id") Long id);
}
