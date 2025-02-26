package com.example.demo.repository;

import com.example.demo.entity.QuanJeansChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface  QuanJeansChiTietRepository extends JpaRepository<QuanJeansChiTiet, Long> {
    @Query("select q from QuanJeansChiTiet q where q.quanJeans.id = :quanJeansId")
    List<QuanJeansChiTiet> findQuanJeansChiTietsById(@Param("quanJeansId") Long quanJeansId);
}
