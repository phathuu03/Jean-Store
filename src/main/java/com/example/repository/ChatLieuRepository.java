package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.ChatLieu;

@Repository
public interface ChatLieuRepository extends JpaRepository<ChatLieu, Long> {
}
