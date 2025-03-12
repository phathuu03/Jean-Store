package com.example.demo.repository;

import com.example.demo.entity.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    @Query(value = "select * from Voucher where DieuKienApDung <= :dieuKien and NgayBatDau <= GETDATE() and GETDATE() <= NgayKetThuc and TrangThai =1", nativeQuery = true)
    List<Voucher> getVoucherByDieuKienApDung(@Param("dieuKien") Double dieuKien);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Voucher set SoLuong = SoLuong - 1 where ID = :id", nativeQuery = true)
    void updateSoLuong(@Param("id") Long id);

    @Query("SELECT v FROM Voucher v WHERE " +
            "(:keyword IS NULL OR LOWER(v.tenVoucher) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
            "AND (:startDate IS NULL OR v.ngayBatDau >= :startDate) " +
            "AND (:endDate IS NULL OR v.ngayKetThuc <= :endDate)")
    List<Voucher> findBySearchConditions(
            @Param("keyword") String keyword,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate);


}
