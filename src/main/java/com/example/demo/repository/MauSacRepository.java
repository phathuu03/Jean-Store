package com.example.demo.repository;

import com.example.demo.entity.ChatLieu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.MauSac;

import java.util.List;


@Repository
public interface MauSacRepository extends JpaRepository<MauSac, Long> {
    @Query(value = "select MauSac.TenMauSac,MauSac.ID from QuanJeansChiTiet join MauSac" +
            " on QuanJeansChiTiet.ID_MauSac = MauSac.ID where ID_Quan = :id and QuanJeansChiTiet.TrangThai = 1 group by MauSac.TenMauSac,MauSac.ID", nativeQuery = true)
    List<Object[]> findTenMauSac(@Param("id") Long id);

    @Query(value = "select TenMauSac from MauSac where ID = :idMauSac", nativeQuery = true)
    String getTenMauSac(@Param("idMauSac") Long idMauSac);

    List<MauSac> findAllByTrangThai(Integer trangThai);

    boolean existsChatLieuByTenMauSac(String tenMauSac);
}
