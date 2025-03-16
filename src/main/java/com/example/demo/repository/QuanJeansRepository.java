package com.example.demo.repository;

import com.example.demo.entity.QuanJeans;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuanJeansRepository extends JpaRepository<QuanJeans, Long> {

    @Query(value = "select TenSanPham from QuanJeans where ID = :id", nativeQuery = true)
    String getNameProduct(@Param("id") Long id);

    @Query(value = "select * from QuanJeans where TrangThai = 1", nativeQuery = true)
    Page<QuanJeans> findAllByTrangThai(Pageable pageable);

    @Query(value = "select * from QuanJeans where ID_ThuongHieu = :id and TrangThai = 1", nativeQuery = true)
    Page<QuanJeans> findAllByThuongHieu(@Param("id") Long id, Pageable pageable);

    @Query(value = "select * from QuanJeans where ID_ChatLieu = :id and TrangThai = 1", nativeQuery = true)
    Page<QuanJeans> findAllByChatLieu(@Param("id") Long id, Pageable pageable);

    @Query(value = "select * from QuanJeans where ID_OngQuan = :id and TrangThai = 1", nativeQuery = true)
    Page<QuanJeans> findAllByOngQuan(@Param("id") Long id, Pageable pageable);

    List<QuanJeans> findByTenSanPhamContainingIgnoreCase(String keyword);

    Page<QuanJeans> findByTenSanPhamContainingIgnoreCase(String search, Pageable pageable);
}
