package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Entity
@Table(name = "Voucher")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50, nullable = false)
    private String tenVoucher;

    @Column(length = 125)
    private String moTa;

    private Integer soLuong;

    private Double phanTramGiamGia;

    private Double giamGiaToiDa;

    @Column(length = 100)
    private Double dieuKienApDung;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngayBatDau;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngayKetThuc;

    private Integer trangThai; // 0: Chưa diễn ra, 1: Đang diễn ra, 2: Đã kết thúc

    @PrePersist
    public void prePersist() {
        if (trangThai == null) {
            this.trangThai = 0; // Mặc định là "Chưa diễn ra"
        }
    }
}
