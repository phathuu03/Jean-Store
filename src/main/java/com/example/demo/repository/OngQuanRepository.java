package com.example.demo.repository;

import com.example.demo.entity.OngQuan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OngQuanRepository extends JpaRepository<OngQuan, Long> {
    List<OngQuan> findAllByTrangThai(Integer trangThai);

    @Query(value = "select OngQuan.TenOngQuan,OngQuan.ID  from QuanJeans join OngQuan on QuanJeans.ID_OngQuan = OngQuan.ID\n" +
            "where QuanJeans.TrangThai = 1 group by OngQuan.TenOngQuan,OngQuan.ID", nativeQuery = true)
    List<Object[]> getOngQuanGroupByQuanJeans();

}
