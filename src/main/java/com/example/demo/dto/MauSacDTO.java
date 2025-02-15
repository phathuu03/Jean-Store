package com.example.demo.dto;

public class MauSacDTO {
    private Long id;
    private String tenMauSac;

    public MauSacDTO(Long id, String tenMauSac) {
        this.id = id;
        this.tenMauSac = tenMauSac;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTenMauSac() {
        return tenMauSac;
    }

    public void setTenMauSac(String tenMauSac) {
        this.tenMauSac = tenMauSac;
    }
}