package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "HoaDon")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class HoaDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Thêm mã hóa đơn tự động từ SQL
    @Column(name = "MaHoaDon", insertable = false, updatable = false)
    private String maHoaDon;

    private Double tongTien;

    private Double phiShip;

    private Double giamGia;

    private Double thanhTien;

    @Column(name = "DiaChiGiaoHang", length = 225)
    private String diaChiGiaoHang;

    private LocalDate ngayThanhToan;

    private LocalDate ngayTao;

    private LocalDate ngaySua;

    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "ID_KhachHang")
    private KhachHang khachHang;

    @ManyToOne
    @JoinColumn(name = "ID_NhanVien")
    private NhanVien nhanVien;

    @ManyToOne
    @JoinColumn(name = "ID_Voucher")
    private Voucher voucher;

    @ManyToOne
    @JoinColumn(name = "ID_PTTT")
    private PTTT pttt;
}
