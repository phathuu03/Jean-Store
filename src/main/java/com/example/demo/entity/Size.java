package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "Size")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Size {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50)
    private String tenSize;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;
}
