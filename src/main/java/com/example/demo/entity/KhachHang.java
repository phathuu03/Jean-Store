package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


@Entity
@Table(name = "KhachHang")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 125, nullable = false)
    private String tenKhachHang;

    @Column(length = 50, nullable = false, unique = true)
    private String tenDangNhap;

    @Column(length = 50, nullable = false)
    private String matKhau;

    @Column(name = "TinhTP")
    private String tinhTP;

    @Column(name = "QuanHuyen")
    private String quanHuyen;

    @Column(name = "PhuongXa")
    private String phuongXa;

    @Column(name = "DiaChiChiTiet")
    private String diaChi;

    @Pattern(regexp = "^(0[0-9]{9}|\\+84[0-9]{9})$", message = "Số điện thoại không hợp lệ")
    @Column(unique = true, nullable = false)
    private String soDienThoai;

    @Email(message = "Email không hợp lệ")
    @Column(unique = true, nullable = false)
    private String email;

    private Boolean gioiTinh;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngayTao;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngaySua;

    private Integer trangThai;

    @PrePersist
    public void prePersist() {
        if (this.trangThai == null) {
            this.trangThai = 0;  // Chỉ đặt mặc định nếu chưa có giá trị
        }
        if (this.ngayTao == null) {  // Giữ nguyên nếu đã có ngày tạo
            this.ngayTao = new Date();
        }
    }

    @PreUpdate
    public void preUpdate() {
        this.ngaySua = new Date();
    }

}

