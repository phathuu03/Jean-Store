package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.ChatLieu;

import java.util.List;

@Repository
public interface ChatLieuRepository extends JpaRepository<ChatLieu, Long> {
    List<ChatLieu> findAllByTrangThai(Integer trangThai);

    @Query(value = "select ChatLieu.TenChatLieu,ChatLieu.ID  from QuanJeans join ChatLieu on QuanJeans.ID_ChatLieu = ChatLieu.ID\n" +
            "where QuanJeans.TrangThai = 1 group by  ChatLieu.TenChatLieu,ChatLieu.ID", nativeQuery = true)
    List<Object[]> getChatLieuGroupByQuanJeans();
    boolean existsChatLieuByTenChatLieu(String tenChatLieu);
}
