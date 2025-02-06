package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;


@Entity
@Table(name = "KhachHang")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 125)
    private String tenKhachHang;


    @Column(length = 50)
    private String tenDangNhap;

    @Column(length = 50)
    private String matKhau;

    @Column(length = 11)
    private String soDienThoai;

    @Column(length = 125)
    private String diaChi;

    @Column(length = 50)
    private String email;

    private Boolean gioiTinh;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;
}
