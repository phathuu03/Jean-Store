package com.example.demo.repository;

import com.example.demo.entity.OngQuan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OngQuanRepository extends JpaRepository<OngQuan, Long> {
}
