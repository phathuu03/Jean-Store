package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.KhachHang;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang, Long> {
    @Query(value = "select * from KhachHang where TenDangNhap like :ten", nativeQuery = true)
    KhachHang findIdByTenDangNhap(@Param("ten") String ten);

    @Query(value = "select * from KhachHang where ID = :id", nativeQuery = true)
    KhachHang getKhachHangById(@Param("id") Long id);

    @Modifying
    @Transactional
    @Query(value = "update KhachHang set NgaySua = GETDATE(),GioiTinh = :gender, TenKhachHang = :tenKhachHang, DiaChi = :diaChi,Email = :email where ID = :id", nativeQuery = true)
    void updateKhachHang(@Param("gender") boolean gender, @Param("tenKhachHang") String tenKhachHang, @Param("diaChi") String diaChi, @Param("email") String email, @Param("id") Long id);

    @Modifying
    @Transactional
    @Query(value = "update KhachHang set MatKhau = :password,NgaySua = GETDATE() where ID = :id", nativeQuery = true)
    void updatePassword(@Param("password") String password, @Param("id") Long id);


    @Modifying
    @Transactional
    @Query(value = "insert into KhachHang values(:name,:username,:password,:sdt,:address,:email,:gender,GETDATE(),null,1)", nativeQuery = true)
    void insertUser(@Param("name") String name, @Param("username") String username, @Param("password") String password, @Param("sdt") String sdt,
                    @Param("address") String address, @Param("email") String email, @Param("gender") Boolean gender);
    @Modifying
    @Transactional
    @Query(value = "update KhachHang set MatKhau = :password where TenDangNhap = :username",nativeQuery = true)
    void updatePasswordByUsername(@Param("password") String password,@Param("username") String username);
}
