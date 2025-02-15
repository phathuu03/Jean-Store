package com.example.demo.repository;

import com.example.demo.entity.OngQuan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OngQuanRepository extends JpaRepository<OngQuan, Long> {
    List<OngQuan> findAllByTrangThai(Integer trangThai);

}
