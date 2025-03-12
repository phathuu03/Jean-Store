package com.example.demo.entity;

import com.example.demo.entity.MauSac;
import com.example.demo.entity.QuanJeansDTO;
import com.example.demo.entity.Size;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "QuanJeansChiTiet")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuanJeansChiTietDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 125)
    private String moTa;

    @Column(name = "Gia")
    private Double gia;

    private Integer soLuong;

    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "ID_MauSac")
    private MauSac mauSac;

    @ManyToOne
    @JoinColumn(name = "ID_Size")
    private Size size;

    @ManyToOne
    @JoinColumn(name = "ID_Quan")
    private QuanJeansDTO quanJeansDTO;

}
