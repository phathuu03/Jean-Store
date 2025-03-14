package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.HoaDon;

import java.util.List;

@Repository
public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {

    @Query("SELECT MONTH(h.ngayThanhToan), SUM(h.tongTien), SUM(h.phiShip), SUM(h.giamGia) " +
            "FROM HoaDon h WHERE YEAR(h.ngayThanhToan) = :nam " +
            "AND h.trangThai = 1 " +
            "GROUP BY MONTH(h.ngayThanhToan) ORDER BY MONTH(h.ngayThanhToan)")
    List<Object[]> getDoanhThuTheoNam(@Param("nam") int nam);

    @Query("SELECT YEAR(h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE h.trangThai = 1 AND h.ngayThanhToan IS NOT NULL " +
            "GROUP BY YEAR(h.ngayThanhToan) ORDER BY YEAR(h.ngayThanhToan)")
    List<Object[]> getDoanhThuCacNam();


    @Query("SELECT COALESCE(SUM(h.phiShip), 0) FROM HoaDon h WHERE h.trangThai = 1")
    long getTongPhiShip();

    @Query("SELECT COALESCE(SUM(h.giamGia), 0) FROM HoaDon h WHERE h.trangThai = 1")
    long getTongGiamGia();

    @Query("SELECT COUNT(hd) FROM HoaDon hd WHERE hd.trangThai = 1")
    int countTatCaDonHangThanhToan();
}
