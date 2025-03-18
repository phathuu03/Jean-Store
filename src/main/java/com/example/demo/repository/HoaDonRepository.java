package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {

    // Thống kê doanh thu theo tháng trong năm
    @Query("SELECT MONTH(h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE YEAR(h.ngayThanhToan) = :nam " +
            "AND h.trangThai = 1 " +
            "GROUP BY MONTH(h.ngayThanhToan) ORDER BY MONTH(h.ngayThanhToan)")
    List<Object[]> getDoanhThuTheoNam(@Param("nam") int nam);

    // Thống kê doanh thu theo ngày trong tháng
    @Query("SELECT DAY(h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE YEAR(h.ngayThanhToan) = :nam " +
            "AND MONTH(h.ngayThanhToan) = :thang " +
            "AND h.trangThai = 1 " +
            "GROUP BY DAY(h.ngayThanhToan) ORDER BY DAY(h.ngayThanhToan)")
    List<Object[]> getDoanhThuTheoThang(@Param("nam") int nam, @Param("thang") int thang);

    // Thống kê doanh thu theo khoảng thời gian
    @Query(value = "SELECT CONVERT(DATE, h.ngayThanhToan), SUM(h.tongTien) " +
            "FROM HoaDon h WHERE h.ngayThanhToan BETWEEN :startDate AND :endDate " +
            "AND h.trangThai = 1 " +
            "GROUP BY CONVERT(DATE, h.ngayThanhToan) " +
            "ORDER BY CONVERT(DATE, h.ngayThanhToan)", nativeQuery = true)
    List<Object[]> getDoanhThuTheoKhoangThoiGian(@Param("startDate") String startDate,
                                                 @Param("endDate") String endDate);

    // Tính tổng doanh thu
    @Query("SELECT SUM(h.tongTien) FROM HoaDon h WHERE h.trangThai = 1")
    Integer tinhTongDoanhThu();

    @Query("SELECT COUNT(hd) FROM HoaDon hd WHERE YEAR(hd.ngayTao) = :year")
    int countSoDonHang(@Param("year") int year);


    @Query(value = "insert into HoaDon OUTPUT INSERTED.ID values " +
            "(:sumMoney,:ship,:discount,:money,:address,null,GETDATE(),null,0,:idUser,null,:idVoucher,:idPTTT)", nativeQuery = true)
    Long saveHoaDon(@Param("sumMoney") Double sumMoney,
                    @Param("ship") Double ship,
                    @Param("discount") Double discount,
                    @Param("money") Double money,
                    @Param("address") String address,
                    @Param("idUser") Long idUser,
                    @Param("idVoucher") Long idVoucher,
                    @Param("idPTTT") Long idPTTT
    );

    @Query(value = "insert into HoaDon OUTPUT INSERTED.ID values " +
            "(:sumMoney,:ship,:discount,:money,:address,null,GETDATE(),null,0,:idUser,null,null,:idPTTT)", nativeQuery = true)
    Long saveHoaDonIsNullVoucher(@Param("sumMoney") Double sumMoney,
                                 @Param("ship") Double ship,
                                 @Param("discount") Double discount,
                                 @Param("money") Double money,
                                 @Param("address") String address,
                                 @Param("idUser") Long idUser,
                                 @Param("idPTTT") Long idPTTT
    );

    @Query(value = "select * from HoaDon where ID_KhachHang =:id", nativeQuery = true)
    List<HoaDon> getHoaDonByIdKhachHang(@Param("id") Long id);


    @Query(value = "select * from HoaDon where ID_KhachHang =:id and trangThai = :status", nativeQuery = true)
    List<HoaDon> getHoaDonByIdKhachHangaAndTrangThai(@Param("id") Long id, @Param("status") Integer status);

    @Modifying
    @Transactional
    @Query(value = "update HoaDon set TrangThai = 4 where ID = :id", nativeQuery = true)
    void updateTrangThaiDaHuy(@Param("id") Long id);


    @Modifying
    @Transactional
    @Query(value = "update HoaDon set TrangThai = 3 where ID = :id", nativeQuery = true)
    void updateTrangThaiHoanThanh(@Param("id") Long id);
}
