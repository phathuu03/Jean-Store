package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.OngQuan;

@Repository
public interface OngQuanRepository extends JpaRepository<OngQuan, Long> {
}
