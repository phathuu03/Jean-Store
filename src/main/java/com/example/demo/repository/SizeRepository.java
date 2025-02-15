package com.example.demo.repository;

import com.example.demo.entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepository extends JpaRepository<Size, Long> {
    @Query(value = "select Size.ID,Size.TenSize from QuanJeansChiTiet " +
            "join Size on QuanJeansChiTiet.ID_Size = Size.ID where ID_Quan = :id group by Size.ID,Size.TenSize",nativeQuery = true)
    List<Object[]> findByIdSize(@Param("id") Long id);

    @Query(value = "select TenSize from Size where ID = :id",nativeQuery = true)
    String getNameSize(@Param("id") Long id);
}
