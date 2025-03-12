package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "QuanJeansChiTiet")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuanJeansChiTiet {
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
    private QuanJeans quanJeans;

}
