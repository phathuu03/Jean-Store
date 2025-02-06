package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "PTTT")
@Data
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class PTTT {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50)
    private String tenPTTT;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;
}
