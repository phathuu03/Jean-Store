package com.example.demo.repository;

import com.example.demo.entity.HinhAnh;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HinhAnhRepository extends JpaRepository<HinhAnh, Long> {
    @Query(value = "select Url from HinhAnh where ID_MauSac =:colorId and ID_QuanJeans = :productId", nativeQuery = true)
    List<String> findImageByColorAndProduct(@Param("colorId") Long colorId, @Param("productId") Long productId);

    @Query(value = "select * from HinhAnh where ID_QuanJeans = :id",nativeQuery = true)
    List<HinhAnh> findHinhAnhByIdQuan(@Param("id") Long id);

    @Query("SELECT ha FROM HinhAnh ha WHERE ha.quanJeans.id = :quanJeansId AND ha.idMauSac = :idMauSac")
    List<HinhAnh> findHinhAnhByQuanJeansAndIdMauSac(@Param("quanJeansId") Long quanJeansId,
                                                    @Param("idMauSac") Long idMauSac);

    List<HinhAnh> findByIdIn(List<Long> ids);

}
