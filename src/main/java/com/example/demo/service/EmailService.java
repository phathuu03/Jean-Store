package com.example.demo.service;

import jakarta.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendResetPasswordEmail(String to, String username) {
        String subject = "Đặt lại mật khẩu của bạn";
        String resetLink = "http://localhost:8080/reset-password?username=" + username;
        String body = "<p>Bạn đã yêu cầu đặt lại mật khẩu.</p>"
                + "<p>Nhấn vào liên kết bên dưới để đặt lại mật khẩu của bạn:</p>"
                + "<p><a href=\"" + resetLink + "\">Đặt lại mật khẩu</a></p>";

        sendEmail(to, subject, body);
    }

    private void sendEmail(String to, String subject, String body) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(body, true);
            helper.setFrom("nguyenblack29022004@gmail.com");

            mailSender.send(message);
        } catch (jakarta.mail.MessagingException e) {
            throw new RuntimeException("Lỗi khi gửi email", e);
        }
    }
}
