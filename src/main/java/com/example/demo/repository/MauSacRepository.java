package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.MauSac;

@Repository
public interface MauSacRepository extends JpaRepository<MauSac, Long> {
}
