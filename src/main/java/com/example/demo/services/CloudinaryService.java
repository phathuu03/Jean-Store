package com.example.demo.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class CloudinaryService {

    private final Cloudinary cloudinary;

    // Constructor để cấu hình Cloudinary với thông tin từ application.properties
    public CloudinaryService(@Value("${cloudinary.cloudName}") String cloudName,
                             @Value("${cloudinary.apiKey}") String apiKey,
                             @Value("${cloudinary.apiSecret}") String apiSecret) {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret));
    }

    // Phương thức tải hình ảnh lên Cloudinary và nhận URL của hình ảnh
    public Map<String, Object> uploadImage(MultipartFile file) throws IOException {
        // Kiểm tra kích thước của file (tối đa 10MB)
        if (file.getSize() > 10 * 1024 * 1024) {
            throw new IllegalArgumentException("File size exceeds the limit of 10MB");
        }

        try {
            // Tải lên Cloudinary
            Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
            return uploadResult;  // Trả về thông tin chi tiết bao gồm URL, public_id, v.v.
        } catch (IOException e) {
            // Xử lý lỗi nếu không thể tải lên
            throw new IOException("Error uploading image to Cloudinary", e);
        }
    }

    // Phương thức để lấy URL của hình ảnh sau khi upload
    public String getImageUrl(MultipartFile file) throws IOException {
        Map<String, Object> uploadResult = uploadImage(file);
        return (String) uploadResult.get("secure_url");  // Trả về URL bảo mật của hình ảnh
    }
}
