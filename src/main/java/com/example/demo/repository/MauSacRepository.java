package com.example.demo.repository;

import com.example.demo.entity.ChatLieu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.MauSac;

import java.util.List;

@Repository
public interface MauSacRepository extends JpaRepository<MauSac, Long> {
    List<MauSac> findAllByTrangThai(Integer trangThai);
}
