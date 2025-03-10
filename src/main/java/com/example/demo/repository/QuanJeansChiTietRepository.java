package com.example.demo.repository;

import com.example.demo.entity.QuanJeansChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface QuanJeansChiTietRepository extends JpaRepository<QuanJeansChiTiet, Long> {
    @Query(value = "select SoLuong from QuanJeansChiTiet where ID_Quan =:idQuan and ID_Size =:idSize and ID_MauSac =:idColor",nativeQuery = true)
    Integer getSoluong(@Param("idQuan") Long idQuan,@Param("idSize") Long idSize,@Param("idColor") Long idColor);

    @Query(value = "select ID from QuanJeansChiTiet where ID_Quan =:idQuan and ID_Size =:idSize and ID_MauSac =:idColor",nativeQuery = true)
    Long getId(@Param("idQuan") Long idQuan,@Param("idSize") Long idSize,@Param("idColor") Long idColor);

    @Modifying
    @Transactional
    @Query(value = "update QuanJeansChiTiet set SoLuong = SoLuong - :quantity where ID = :id",nativeQuery = true)
    void updateSoLuong(@Param("quantity") Integer quantity,@Param("id") Long id);

    @Query(value = "select Gia from QuanJeansChiTiet where ID = :id",nativeQuery = true)
    Double getPirce(@Param("id") Long id);

    @Query(value = "select * from QuanJeansChiTiet where ID_Quan = :id",nativeQuery = true)
    List<QuanJeansChiTiet> findQuanJeansChiTietByIdQuan(@Param("id") Long id);
}