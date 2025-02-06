package com.example.demo.repository;

import com.example.demo.entity.PTTT;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PTTTRepository extends JpaRepository<PTTT, Long> {
}
