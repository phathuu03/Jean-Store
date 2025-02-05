package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.PTTT;

@Repository
public interface PTTTRepository extends JpaRepository<PTTT, Long> {
}
