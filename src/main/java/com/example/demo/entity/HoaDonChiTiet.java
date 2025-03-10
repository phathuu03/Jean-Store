package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "HoaDonChiTiet")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class HoaDonChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer soLuong;

    private Double donGia;

    private Double tongTien;

    private Date ngayThanhToan;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "ID_HoaDon")
    private HoaDon hoaDon;

    @ManyToOne
    @JoinColumn(name = "ID_QuanJeansCT")
    private QuanJeansChiTiet quanJeansChiTiet;

    @ManyToOne
    @JoinColumn(name = "ID_PTTT")
    private PTTT pttt;
}
