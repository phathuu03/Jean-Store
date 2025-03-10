package com.example.demo.repository;

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
}
