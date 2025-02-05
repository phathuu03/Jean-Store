package com.example.entity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "GioHangChiTiet")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GioHangChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 125)
    private String moTa;

    private Integer soLuong;

    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "ID_KhachHang")
    private KhachHang khachHang;

    @ManyToOne
    @JoinColumn(name = "ID_QuanJeansCT")
    private QuanJeansChiTiet quanJeansChiTiet;
}
