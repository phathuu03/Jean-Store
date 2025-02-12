package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "HinhAnh")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class HinhAnh {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 500)
    private String url;

    @Column(name = "ID_MauSac")
    private Integer idMauSac;

    @Column(name = "Boolean")
    private Boolean active;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "ID_QuanJeans")
    private QuanJeans quanJeans;
}
