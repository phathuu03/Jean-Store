package com.example.demo.controller;

import com.example.demo.entity.QuanJeans;
import com.example.demo.repository.HinhAnhRepository;
import com.example.demo.repository.QuanJeansChiTietRepository;
import com.example.demo.repository.QuanJeansRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @Autowired
    private HinhAnhRepository hinhAnhRepository;
    @Autowired
    private QuanJeansRepository quanJeansRepository;
    @Autowired QuanJeansChiTietRepository quanJeansChiTietRepository;

    @GetMapping("/home")
    public String viewHome(Model model) {
//        model.addAttribute("hinhAnh",hinhAnhRepository.findAll());
        model.addAttribute("quanJeans",quanJeansRepository.findAll());
//        model.addAttribute("quanJeansCT",quanJeansChiTietRepository.findAllById());
        return "online/home";
    }
}
