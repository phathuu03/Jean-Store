package com.example.demo.model;

public class CloudinaryUploadResult {
    private String secureUrl;
    private String publicId;

    // Constructor
    public CloudinaryUploadResult(String secureUrl, String publicId) {
        this.secureUrl = secureUrl;
        this.publicId = publicId;
    }

    // Getter và Setter
    public String getSecureUrl() {
        return secureUrl;
    }

    public void setSecureUrl(String secureUrl) {
        this.secureUrl = secureUrl;
    }

    public String getPublicId() {
        return publicId;
    }

    public void setPublicId(String publicId) {
        this.publicId = publicId;
    }
}
