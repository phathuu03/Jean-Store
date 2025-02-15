package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.KhachHang;

@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang, Long> {
    @Query(value = "select * from KhachHang where TenDangNhap like :ten",nativeQuery = true)
    KhachHang findIdByTenDangNhap(@Param("ten") String ten);
    @Query(value = "select * from KhachHang where ID = :id",nativeQuery = true)
    KhachHang getKhachHangById(@Param("id") Long id);

}
