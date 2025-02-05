package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.MauSac;

@Repository
public interface MauSacRepository extends JpaRepository<MauSac, Long> {
}
