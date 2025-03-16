package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.HoaDon;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {

    Page<HoaDon> findByTrangThai(int trangThai, Pageable pageable);
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

    @Query(value = "insert into HoaDon OUTPUT INSERTED.ID values " +
            "(:sumMoney,:address,null,GETDATE(),null,0,:idUser,null,:idVoucher,:idPTTT)",nativeQuery = true)
    Long saveHoaDon(@Param("sumMoney") Double sumMoney,
                    @Param("address") String address,
                    @Param("idUser") Long idUser,
                    @Param("idVoucher") Long idVoucher,
                    @Param("idPTTT") Long idPTTT
                    );

    @Query(value = "insert into HoaDon OUTPUT INSERTED.ID values " +
            "(:sumMoney,:address,null,GETDATE(),null,0,:idUser,null,null,:idPTTT)",nativeQuery = true)
    Long saveHoaDonIsNullVoucher(@Param("sumMoney") Double sumMoney,
                    @Param("address") String address,
                    @Param("idUser") Long idUser,
                    @Param("idPTTT") Long idPTTT
    );

    @Query(value = "select * from HoaDon where ID_KhachHang =:id",nativeQuery = true)
    List<HoaDon> getHoaDonByIdKhachHang(@Param("id") Long id);


    @Query(value = "select * from HoaDon where ID_KhachHang =:id and trangThai = :status",nativeQuery = true)
    List<HoaDon> getHoaDonByIdKhachHangaAndTrangThai(@Param("id") Long id,@Param("status") Integer status);

    @Modifying
    @Transactional
    @Query(value = "update HoaDon set TrangThai = 4 where ID = :id",nativeQuery = true)
    void updateTrangThaiDaHuy(@Param("id") Long id);


    @Modifying
    @Transactional
    @Query(value = "update HoaDon set TrangThai = 3 where ID = :id",nativeQuery = true)
    void updateTrangThaiHoanThanh(@Param("id") Long id);

    // Tìm kiếm theo mã hóa đơn hoặc địa chỉ giao hàng với phân trang
    @Query("SELECT h FROM HoaDon h WHERE h.maHoaDon LIKE %:search% OR h.diaChiGiaoHang LIKE %:search%")
    Page<HoaDon> searchHoaDon(@Param("search") String search, Pageable pageable);

}
