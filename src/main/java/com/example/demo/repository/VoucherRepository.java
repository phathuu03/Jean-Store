package com.example.demo.repository;

import com.example.demo.entity.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    @Query(value = "select * from Voucher where DieuKienApDung <= :dieuKien and NgayBatDau <= GETDATE() and GETDATE() <= NgayKetThuc",nativeQuery = true)
    List<Voucher> getVoucherByDieuKienApDung(@Param("dieuKien") Double dieuKien);
}
