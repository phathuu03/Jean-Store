package com.example.demo.services;

import com.example.demo.entity.ChatLieu;
import com.example.demo.entity.OngQuan;
import com.example.demo.repository.ChatLieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ChatLieuService {
    @Autowired
    private ChatLieuRepository chatLieuRepository;

    public List<ChatLieu> getAllChatLieu() {
        return chatLieuRepository.findAll();
    }

    public List<ChatLieu> getAllActiveChatLieu() {
        return chatLieuRepository.findAllByTrangThai(1);
    }

    public ChatLieu saveChatLieu(ChatLieu chatLieu) {

        chatLieu.setNgayTao(new Date());
        return chatLieuRepository.save(chatLieu);
    }

    public Boolean exitsChatLieu(String tenChatLieu){
        return chatLieuRepository.existsChatLieuByTenChatLieu(tenChatLieu);
    }




    public Page<ChatLieu> getAllChatLieu(Pageable pageable) {
        return chatLieuRepository.findAll(pageable);
    }

    public void deleteChatLieu(Long id) {
        ChatLieu chatLieu = chatLieuRepository.findById(id).orElseThrow();
        if (chatLieu != null) {
            if (chatLieu.getTrangThai() == 0) {
                chatLieu.setTrangThai(1); // Đổi trạng thái thành không hoạt động
                chatLieu.setNgaySua(new Date());
                chatLieuRepository.save(chatLieu);
            } else {
                chatLieu.setNgaySua(new Date());
                chatLieu.setTrangThai(0); // Đổi trạng thái thành không hoạt động
                chatLieuRepository.save(chatLieu);
            }
        }
    }

    // Lấy Chất Liệu theo ID
    public ChatLieu getChatLieuById(Long id) {
        return chatLieuRepository.findById(id).orElseThrow(() -> new RuntimeException("Chất Liệu không tồn tại"));
    }

}
