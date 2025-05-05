package com.example.demo.repository;

import com.example.demo.entity.ThuongHieu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ThuongHieuRepository extends JpaRepository<ThuongHieu, Long> {
    List<ThuongHieu> findAllByTrangThai(Integer trangThai);

    @Query(value = "select ThuongHieu.TenThuongHieu,ThuongHieu.ID  from QuanJeans join ThuongHieu on QuanJeans.ID_ThuongHieu = ThuongHieu.ID\n" +
            "where QuanJeans.TrangThai = 1 group by TenThuongHieu,ThuongHieu.ID", nativeQuery = true)
    List<Object[]> getThuongHieuGroupByQuanJeans();

    boolean existsChatLieuByTenThuongHieu(String tenThuongHieu);

}
