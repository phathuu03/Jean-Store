package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
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

    // Thêm mã hóa đơn tự động từ SQL
    @Column(name = "MaHoaDon", insertable = false, updatable = false)
    private String maHoaDon;


    private Double tongTien;

    private Double phiShip;

    private Double giamGia;

    private Double thanhTien;

    @Column(name = "DiaChiGiaoHang", length = 225)
    private String diaChiGiaoHang;


    private Date ngayThanhToan;

    private Date ngayTao = new Date();

    private Date ngaySua;

    private Integer trangThai;

    private String ghiChu;

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

    public Integer getPublicTrangThai (){
        return trangThai;
    }
}
