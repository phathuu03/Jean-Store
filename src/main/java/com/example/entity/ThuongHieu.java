package com.example.entity;
import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "ThuongHieu")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ThuongHieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50)
    private String tenThuongHieu;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;
}
