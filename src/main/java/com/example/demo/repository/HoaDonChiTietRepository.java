package com.example.demo.repository;

import com.example.demo.entity.HoaDonChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface HoaDonChiTietRepository extends JpaRepository<HoaDonChiTiet, Long> {
    @Modifying
    @Transactional
    @Query(value = "insert into HoaDonChiTiet values" +
            "(:quantity,:price,:sumMoney,null,GETDATE(),null,1,:idHoaDon,:idQuanCT,null)", nativeQuery = true)
    void insertHDCT(@Param("quantity") Integer quantity,
                    @Param("price") Double price,
                    @Param("sumMoney") Double sumMoney,
                    @Param("idHoaDon") Long idHoaDon,
                    @Param("idQuanCT") Long idQuanCT
    );

    @Query(value = "select * from HoaDonChiTiet where ID_HoaDon =:id", nativeQuery = true)
    List<HoaDonChiTiet> getHoaDonChiTietByHoaDon(@Param("id") Long id);

    @Query("select hdct from HoaDonChiTiet  hdct where hdct.hoaDon.id = :idHoaDon")
    List<HoaDonChiTiet> findAllByIdHoaDon(@Param("idHoaDon") Long idHoaDon);
}
