package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
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

    private String tenNhanVien;

    private String tenDangNhap;

    private String matKhau;

    @Pattern(regexp = "0[0-9]{9}", message = "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0")
    @Column(unique = true)
    private String soDienThoai;

    private String diaChi;

    @Email(message = "Email không hợp lệ")
    @Column(unique = true)
    private String email;

    private Boolean gioiTinh;

    private String chucVu;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngayTao = new Date();

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngaySua;

    private Integer trangThai;

    @PrePersist
    public void prePersist() {
        if (trangThai == null) {
            this.trangThai = 0; // Mặc định là "Chưa diễn ra"
        }
    }
}
