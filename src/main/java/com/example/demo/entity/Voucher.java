package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "Voucher")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50)
    private String tenVoucher;

    @Column(length = 125)
    private String moTa;

    private Integer soLuong;

    private Double phanTramGiamGia;

    private Double dieuKienApDung;

    private Date ngayBatDau;

    private Date ngayKetThuc;

    private Integer trangThai;
}
