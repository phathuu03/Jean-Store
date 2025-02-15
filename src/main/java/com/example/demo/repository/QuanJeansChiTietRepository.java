package com.example.demo.repository;

import com.example.demo.entity.MauSac;
import com.example.demo.entity.QuanJeansChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuanJeansChiTietRepository extends JpaRepository<QuanJeansChiTiet, Long> {
    @Query(value = "select SoLuong from QuanJeansChiTiet where ID_Quan =:idQuan and ID_Size =:idSize and ID_MauSac =:idColor",nativeQuery = true)
    Integer getSoluong(@Param("idQuan") Long idQuan,@Param("idSize") Long idSize,@Param("idColor") Long idColor);

    @Query(value = "select ID from QuanJeansChiTiet where ID_Quan =:idQuan and ID_Size =:idSize and ID_MauSac =:idColor",nativeQuery = true)
    Long getId(@Param("idQuan") Long idQuan,@Param("idSize") Long idSize,@Param("idColor") Long idColor);
}