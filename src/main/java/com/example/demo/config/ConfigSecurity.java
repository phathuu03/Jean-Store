package com.example.demo.config;

import com.example.demo.entity.KhachHang;
import com.example.demo.service.KhachHangService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Configuration
@EnableWebSecurity
public class ConfigSecurity {

    private final KhachHangService khachHangService;

    public ConfigSecurity(KhachHangService khachHangService) {
        this.khachHangService = khachHangService;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        List<UserDetails> users = khachHangService.getAllKhachHang().stream()
                .map(khachHang -> User.builder()
                        .username(khachHang.getTenDangNhap())
                        .password(passwordEncoder().encode(khachHang.getMatKhau()))
                        .roles("KhachHang")
                        .build()
                ).collect(Collectors.toList());

        return new InMemoryUserDetailsManager(users);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/order/**").authenticated() // Chặn truy cập /cart/
                        .anyRequest().permitAll()
                )
                .formLogin(login -> login
                        .loginProcessingUrl("/login")
                        .defaultSuccessUrl("/cart/detail", true)
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()
                );
//        http
//                .authorizeHttpRequests(auth -> auth
//                        .requestMatchers("/client/**").authenticated()
//                ).formLogin(login -> login
//                .loginProcessingUrl("/login")
//                .defaultSuccessUrl("/client/detail", true)
//                .permitAll()
//        ).logout(logout -> logout
//                .logoutUrl("/logout")
//                .logoutSuccessUrl("/login?logout")
//                .permitAll()
//        );
        return http.build();
    }


}
