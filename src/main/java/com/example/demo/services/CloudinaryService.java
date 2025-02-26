package com.example.demo.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
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
    public CompletableFuture<String> uploadImageAsync(MultipartFile file) {
        try {
            // Kiểm tra kích thước file (giới hạn 10MB)
            if (file.getSize() > 10 * 1024 * 1024) {
                throw new IllegalArgumentException("File size exceeds the limit of 10MB");
            }

            // Upload ảnh lên Cloudinary
            Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());

            // Lấy và trả về URL ảnh
            return CompletableFuture.completedFuture((String) uploadResult.get("secure_url"));
        } catch (IOException e) {
            throw new RuntimeException("Lỗi khi tải ảnh lên Cloudinary: " + file.getOriginalFilename(), e);
        }
    }

    // Tải lên nhiều file ảnh song song
    public List<String> uploadMultipleImages(MultipartFile[] files) {
        List<CompletableFuture<String>> futures = List.of(files).stream()
                .filter(file -> !file.isEmpty()) // Bỏ qua file rỗng
                .map(this::uploadImageAsync) // Gọi upload song song
                .collect(Collectors.toList());

        // Đợi tất cả file upload xong và lấy danh sách URL ảnh
        return futures.stream()
                .map(CompletableFuture::join)
                .collect(Collectors.toList());
    }
}
