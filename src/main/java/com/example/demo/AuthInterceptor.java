package com.example.demo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Arrays;
import java.util.List;

public class AuthInterceptor implements HandlerInterceptor {

    // Các đường dẫn mà Nhân Viên được truy cập
    private static final List<String> EMPLOYEE_ALLOWED_PATHS = Arrays.asList(
            "/index",
            "/api/quan-ly/hoa-don",              // Quản lý hóa đơn
            "/view-trang-thai-don-hang"         // Quản lý khách hàng
    );

    // Các đường dẫn không cần login (trang public)
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/home"
    );

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        System.out.println("🔍 Interceptor kiểm tra URI: " + uri);

        // ✅ Nếu là trang public → Cho qua luôn
        for (String publicPath : PUBLIC_PATHS) {
            if (uri.startsWith(publicPath)) {
                System.out.println("✅ Trang công khai, cho phép truy cập: " + uri);
                return true;
            }
        }

        HttpSession session = request.getSession(false);

        // ❌ Nếu chưa login
        if (session == null || session.getAttribute("userRole") == null) {
            System.out.println("❌ Chưa đăng nhập, chuyển hướng tới /login");
            response.sendRedirect("/login");
            return false;
        }

        String role = (String) session.getAttribute("userRole");

        // ✅ Nếu là ADMIN → Cho phép tất cả
        if ("ADMIN".equals(role)) {
            System.out.println("✅ ADMIN truy cập, cho phép: " + uri);
            return true;
        }

        // ✅ Nếu là EMPLOYEE → Kiểm tra quyền truy cập
        if ("EMPLOYEE".equals(role)) {
            for (String allowedPath : EMPLOYEE_ALLOWED_PATHS) {
                if (uri.startsWith(allowedPath)) {
                    System.out.println("✅ EMPLOYEE được phép truy cập: " + uri);
                    return true;
                }
            }

            // ❌ Không có quyền
            System.out.println("⛔ EMPLOYEE không có quyền truy cập: " + uri);
            response.sendRedirect("/error/unauthorized");
            return false;
        }

        // ❌ Vai trò không xác định
        System.out.println("⛔ Vai trò không hợp lệ: " + role);
        response.sendRedirect("/login");
        return false;
    }
}
