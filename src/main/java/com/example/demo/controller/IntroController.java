package com.example.demo.controller;

import jakarta.persistence.Column;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IntroController {
    @GetMapping("/intro")
    public String pageIntro(){

        return "khachang/login/intro";
    }
}
