package com.example.demo.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import java.io.IOException;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // Lấy URL người dùng yêu cầu trước đó
        DefaultSavedRequest savedRequest = (DefaultSavedRequest) new HttpSessionRequestCache().getRequest(request, response);

        String redirectUrl = "/home"; // URL mặc định nếu không có yêu cầu trước đó

        if (savedRequest != null) {
            String requestUrl = savedRequest.getRequestURI();

            if (requestUrl.startsWith("/order/")) {
                redirectUrl = "/order/checkout";
            } else if (requestUrl.startsWith("/order-history")) {
                redirectUrl = "/order-history";
            }else if(requestUrl.startsWith("/user/detail")){
                redirectUrl = "/user/detail";
            }
        }
        response.sendRedirect(redirectUrl);
    }
}