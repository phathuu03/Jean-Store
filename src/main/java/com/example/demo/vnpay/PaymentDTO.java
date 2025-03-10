package com.example.demo.vnpay;


import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class PaymentDTO {
        private String code;
        private String message;
        private String paymentUrl;
}
