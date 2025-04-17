package com.example.demo;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AuthInterceptor())
                .addPathPatterns(
                        "/index",
                        "/nhan-vien/hien-thi",
                        "/khach-hang",
                        "/api/quan-jean/quanjeans",
                        "/api/quan-ly/chuyen-muc/chat-lieu",
                        "/api/quan-ly/chuyen-muc/ong-quan",
                        "/api/quan-ly/chuyen-muc/thuong-hieu",
                        "/api/quan-ly/list-mau-sac",
                        "/api/quan-ly/list-kich-thuoc",
                        "/api/quan-ly/hoa-don/view-hoa-don",
                        "/view-trang-thai-don-hang",
                        "/voucher/hien-thi",
                        "/thong-ke"
                )
                .excludePathPatterns(
                        "/login",              // Không chặn trang login
                        "/logout",             // Không chặn logout nếu có
                        "/home",               // Không chặn trang public (nếu có)
                        "/error/**",           // Cho phép vào trang lỗi
                        "/css/**",             // Tài nguyên tĩnh
                        "/js/**",
                        "/images/**",
                        "/webjars/**"
                );
    }
}
