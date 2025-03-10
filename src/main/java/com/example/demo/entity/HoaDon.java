package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
import java.util.List;

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

    private Double tongTien;

    private String diaChiGiaoHang;

    private Date ngayThanhToan;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;

    private String diaChiGiaoHang;

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

    @OneToMany(mappedBy = "hoaDon", cascade = CascadeType.ALL)
    private List<HoaDonChiTiet> hoaDonChiTiets;

    public String getTrangThai() {
        if (trangThai == 0) {
            return "Chờ xác nhận";
        }
        if (trangThai == 1) {
            return "Chờ giao hàng";
        }
        if (trangThai == 2) {
            return "Đang giao hàng";
        }
        if (trangThai == 3) {
            return "Hoàn thành";
        }
        if (trangThai == 4) {
            return "Đã hủy";
        }
        return null;
    }
}
