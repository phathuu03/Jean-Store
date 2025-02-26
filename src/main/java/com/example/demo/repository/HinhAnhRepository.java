package com.example.demo.repository;

import com.example.demo.entity.QuanJeansChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.HinhAnh;

import java.util.List;

@Repository
public interface HinhAnhRepository extends JpaRepository<HinhAnh, Long> {
    @Query("SELECT ha FROM HinhAnh ha WHERE ha.quanJeans.id = :quanJeansId AND ha.idMauSac = :idMauSac")
    List<HinhAnh> findHinhAnhByQuanJeansAndIdMauSac(@Param("quanJeansId") Long quanJeansId,
                                                    @Param("idMauSac") Long idMauSac);


}
