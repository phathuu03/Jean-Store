package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.HinhAnh;

import java.util.List;

@Repository
public interface HinhAnhRepository extends JpaRepository<HinhAnh, Long> {
//    @Query(value = " select QuanJeans.TenSanPham,HinhAnh.Url from HinhAnh join" +
//            " QuanJeans on HinhAnh.ID_QuanJeans = QuanJeans.ID where HinhAnh.Boolean = 1", nativeQuery = true)
//    List<HinhAnh> hinhAnhHome();

}
