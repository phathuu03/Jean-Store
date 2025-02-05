package com.example.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "NhanVien")
@Data
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class NhanVien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 125)
    private String tenNhanVien;

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

    @Column(length = 50)
    private String chucVu;

    private Date ngayTao;

    private Date ngaySua;

    private Integer trangThai;
}
