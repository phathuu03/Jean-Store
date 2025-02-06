package com.example.demo.dto;


public class QuanJeansHinhAnhDto {

    private String tenSanPham;
    private String url;

    public QuanJeansHinhAnhDto(String tenSanPham, String url) {
        this.tenSanPham = tenSanPham;
        this.url = url;
    }

    public String getTenSanPham() {
        return tenSanPham;
    }

    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
