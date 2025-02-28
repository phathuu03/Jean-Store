package com.example.demo.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.demo.model.CloudinaryUploadResult;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

@Service
public class CloudinaryService {

    private final Cloudinary cloudinary;

    public CloudinaryService(@Value("${cloudinary.cloudName}") String cloudName,
                             @Value("${cloudinary.apiKey}") String apiKey,
                             @Value("${cloudinary.apiSecret}") String apiSecret) {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret));
    }

    // Tải lên một file ảnh (ASYNC)
    @Async
    public CompletableFuture<CloudinaryUploadResult> uploadImageAsync(MultipartFile file) {
        try {
            // Kiểm tra kích thước file (giới hạn 10MB)
            if (file.getSize() > 10 * 1024 * 1024) {
                throw new IllegalArgumentException("File size exceeds the limit of 10MB");
            }

            // Upload ảnh lên Cloudinary
            Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());

            // Lấy URL ảnh và public_id
            String secureUrl = (String) uploadResult.get("secure_url");
            String publicId = (String) uploadResult.get("public_id");

            // Trả về đối tượng chứa URL và public_id
            return CompletableFuture.completedFuture(new CloudinaryUploadResult(secureUrl, publicId));
        } catch (IOException e) {
            throw new RuntimeException("Lỗi khi tải ảnh lên Cloudinary: " + file.getOriginalFilename(), e);
        }
    }


    // Tải lên nhiều file ảnh song song
    public List<CloudinaryUploadResult> uploadMultipleImages(MultipartFile[] files) {
        List<CompletableFuture<CloudinaryUploadResult>> futures = List.of(files).stream()
                .filter(file -> !file.isEmpty()) // Bỏ qua file rỗng
                .map(this::uploadImageAsync) // Gọi upload song song
                .collect(Collectors.toList());

        // Đợi tất cả file upload xong và lấy danh sách kết quả
        return futures.stream()
                .map(CompletableFuture::join)
                .collect(Collectors.toList());
    }

    @Async
    public CompletableFuture<Boolean> deleteImageAsync(String publicId) {
        if (publicId == null) {
            System.out.println("Không xóa ảnh trên Cloudinary vì publicId = null");
            return CompletableFuture.completedFuture(false);
        }
        try {
            Map<String, Object> result = cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
            boolean success = "ok".equals(result.get("result"));
            return CompletableFuture.completedFuture(success);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi xóa ảnh trên Cloudinary với publicId: " + publicId, e);
        }
    }


}
