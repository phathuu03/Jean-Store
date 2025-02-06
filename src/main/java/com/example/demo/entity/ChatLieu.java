package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "ChatLieu")
@Data
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class ChatLieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50)
    private String tenChatLieu;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;
}
