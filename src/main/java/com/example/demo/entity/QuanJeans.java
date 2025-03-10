package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "QuanJeans")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuanJeans {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100)
    private String tenSanPham;

    private LocalDate ngayTao = LocalDate.now();

    private LocalDate ngaySua;

    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "ID_ThuongHieu")
    private ThuongHieu thuongHieu;

    @ManyToOne
    @JoinColumn(name = "ID_OngQuan")
    private OngQuan ongQuan;

    @ManyToOne
    @JoinColumn(name = "ID_ChatLieu")
    private ChatLieu chatLieu;

}
