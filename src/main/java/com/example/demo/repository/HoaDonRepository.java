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

    @Query("SELECT MONTH(h.ngayThanhToan), SUM(h.thanhTien), SUM(h.phiShip), SUM(h.giamGia) " +
            "FROM HoaDon h WHERE YEAR(h.ngayThanhToan) = :nam " +
            "AND h.trangThai = 3 " +
            "GROUP BY MONTH(h.ngayThanhToan) ORDER BY MONTH(h.ngayThanhToan)")
    List<Object[]> getDoanhThuTheoNam(@Param("nam") int nam);

    @Query("SELECT YEAR(h.ngayThanhToan), SUM(h.thanhTien) " +
            "FROM HoaDon h WHERE h.trangThai = 3 AND h.ngayThanhToan IS NOT NULL " +
            "GROUP BY YEAR(h.ngayThanhToan) ORDER BY YEAR(h.ngayThanhToan)")
    List<Object[]> getDoanhThuCacNam();


    @Query("SELECT COALESCE(SUM(h.phiShip), 0) FROM HoaDon h WHERE h.trangThai = 3")
    long getTongPhiShip();

    @Query("SELECT COALESCE(SUM(h.giamGia), 0) FROM HoaDon h WHERE h.trangThai = 3")
    long getTongGiamGia();

    @Query("SELECT COUNT(hd) FROM HoaDon hd WHERE hd.trangThai = 3")
    int countTatCaDonHangThanhToan();

    Page<HoaDon> findByTrangThai(int trangThai, Pageable pageable);

    // Tìm kiếm theo mã hóa đơn hoặc địa chỉ giao hàng với phân trang
    @Query("SELECT h FROM HoaDon h WHERE h.maHoaDon LIKE %:search% OR h.diaChiGiaoHang LIKE %:search%")
    Page<HoaDon> searchHoaDon(@Param("search") String search, Pageable pageable);

    @Query(value = "select * from HoaDon where ID_KhachHang =:id", nativeQuery = true)
    List<HoaDon> getHoaDonByIdKhachHang(@Param("id") Long id);

    @Query(value = "select * from HoaDon where ID_KhachHang =:id and trangThai = :status", nativeQuery = true)
    List<HoaDon> getHoaDonByIdKhachHangaAndTrangThai(@Param("id") Long id, @Param("status") Integer status);


    @Query(value = "insert into HoaDon OUTPUT INSERTED.ID values " +
            "(:sumMoney,:ship,:discount,:money,:address,null,GETDATE(),null,0,:idUser,null,null,:idPTTT,null)", nativeQuery = true)
    Long saveHoaDonIsNullVoucher(@Param("sumMoney") Double sumMoney,
                                 @Param("ship") Double ship,
                                 @Param("discount") Double discount,
                                 @Param("money") Double money,
                                 @Param("address") String address,
                                 @Param("idUser") Long idUser,
                                 @Param("idPTTT") Long idPTTT
    );

    @Modifying
    @Transactional
    @Query(value = "update HoaDon set TrangThai = 4,GhiChu= :ghiChu where ID = :id", nativeQuery = true)
    void updateTrangThaiDaHuy(@Param("id") Long id,@Param("ghiChu") String ghiChu);

    @Modifying
    @Transactional
    @Query(value = "update HoaDon set TrangThai = 3,NgayThanhToan = GETDATE() where ID = :id", nativeQuery = true)
    void updateTrangThaiHoanThanh(@Param("id") Long id);


    @Query(value = "insert into HoaDon OUTPUT INSERTED.ID values " +
            "(:sumMoney,:ship,:discount,:money,:address,null,GETDATE(),null,0,:idUser,null,:idVoucher,:idPTTT,null)", nativeQuery = true)
    Long saveHoaDon(@Param("sumMoney") Double sumMoney,
                    @Param("ship") Double ship,
                    @Param("discount") Double discount,
                    @Param("money") Double money,
                    @Param("address") String address,
                    @Param("idUser") Long idUser,
                    @Param("idVoucher") Long idVoucher,
                    @Param("idPTTT") Long idPTTT
    );

}
