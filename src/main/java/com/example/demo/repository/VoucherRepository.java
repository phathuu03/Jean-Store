package com.example.demo.repository;

import com.example.demo.entity.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    @Query("SELECT v FROM Voucher v WHERE " +
            "(:keyword IS NULL OR LOWER(v.tenVoucher) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
            "AND (:startDate IS NULL OR v.ngayBatDau >= :startDate) " +
            "AND (:endDate IS NULL OR v.ngayKetThuc <= :endDate)")
    List<Voucher> findBySearchConditions(
            @Param("keyword") String keyword,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate);

}
