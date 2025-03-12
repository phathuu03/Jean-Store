package com.example.demo.controller.online;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginOnlineController {
    @GetMapping("/online/login")
    public String login(){
        return "online/login/login";
    }

    @GetMapping("/online/register")
    public String register(){
        return "online/login/register";
    }
}
