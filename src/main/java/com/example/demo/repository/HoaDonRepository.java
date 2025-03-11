package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.HoaDon;

import java.util.List;

@Repository
public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {

    // 🔹 Thống kê doanh thu theo tháng trong năm
    @Query("SELECT MONTH(h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE YEAR(h.ngayThanhToan) = :nam " +
            "AND h.trangThai = 1 " +
            "GROUP BY MONTH(h.ngayThanhToan) ORDER BY MONTH(h.ngayThanhToan)")
    List<Object[]> getDoanhThuTheoNam(@Param("nam") int nam);

    // 🔹 Thống kê doanh thu theo năm
    @Query("SELECT YEAR(h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE h.trangThai = 1 " +
            "GROUP BY YEAR(h.ngayThanhToan) ORDER BY YEAR(h.ngayThanhToan)")
    List<Object[]> getDoanhThuCacNam();

    // 🔹 Thống kê doanh thu theo ngày trong tháng
    @Query("SELECT DAY(h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE YEAR(h.ngayThanhToan) = :nam " +
            "AND MONTH(h.ngayThanhToan) = :thang " +
            "AND h.trangThai = 1 " +
            "GROUP BY DAY(h.ngayThanhToan) ORDER BY DAY(h.ngayThanhToan)")
    List<Object[]> getDoanhThuTheoThang(@Param("nam") int nam, @Param("thang") int thang);

    // 🔹 Tính tổng doanh thu (chỉ tính đơn đã thanh toán)
    @Query("SELECT SUM(h.tongTien) FROM HoaDon h WHERE h.trangThai = 1")
    Integer tinhTongDoanhThu();

    // 🔹 Đếm tất cả đơn hàng đã thanh toán
    @Query("SELECT COUNT(hd) FROM HoaDon hd WHERE hd.trangThai = 1")
    int countTatCaDonHangThanhToan();

}
