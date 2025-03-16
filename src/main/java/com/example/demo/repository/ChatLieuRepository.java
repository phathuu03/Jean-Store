package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.ChatLieu;

import java.util.List;

@Repository
public interface ChatLieuRepository extends JpaRepository<ChatLieu, Long> {
    List<ChatLieu> findAllByTrangThai(Integer trangThai);
    boolean existsChatLieuByTenChatLieu(String tenChatLieu);
}
