package com.example.demo.repository;

import com.example.demo.entity.GioHangChiTietDTO;
import com.example.demo.entity.GioHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface GioHangChiTietRepository extends JpaRepository<GioHangChiTiet, Long> {

    @Modifying
    @Transactional
    @Query(value = "update GioHangChiTiet set SoLuong = SoLuong + :quantity where ID_QuanJeansCT = :idQuan and ID_KhachHang = :idUser", nativeQuery = true)
    void setSoLuong(@Param("quantity") Integer quantity, @Param("idQuan") Long idQuan, @Param("idUser") Long idUser);

    @Modifying
    @Transactional
    @Query(value = "delete GioHangChiTiet where ID_KhachHang = :id", nativeQuery = true)
    void deleteGioHangChiTietByIdKhachHang(@Param("id") Long id);

    @Modifying
    @Transactional
    @Query(value = "delete GioHangChiTiet where ID_KhachHang = :idKhachHang and ID_QuanJeansCT = :idQuan", nativeQuery = true)
    void deleteGioHangChiTietByIdKhachHangAndIdQuanJeansChiTiet(@Param("idKhachHang") Long idKhachHang, @Param("idQuan") Long idQuan);

    @Modifying
    @Transactional
    @Query(value = "update GioHangChiTiet set SoLuong = :quantity where ID_QuanJeansCT = :idQuan and ID_KhachHang = :idUser", nativeQuery = true)
    void updateSoLuongOnClickCart(@Param("quantity") Integer quantity, @Param("idQuan") Long idQuan, @Param("idUser") Long idUser);
}
