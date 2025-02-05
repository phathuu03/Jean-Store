package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.ThuongHieu;

@Repository
public interface ThuongHieuRepository extends JpaRepository<ThuongHieu, Long> {
}
