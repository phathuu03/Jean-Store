package com.example.demo.controller.online;

import com.example.demo.repository.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class MauSacController {
    @Autowired
    private MauSacRepository mauSacRepository;

    @GetMapping("/getNameColor")
    @ResponseBody
    public ResponseEntity<?> getNameColor(@RequestParam("idMauSac") Long idMauSac){
        String name = mauSacRepository.getTenMauSac(idMauSac);
        if (name == null){
            return ResponseEntity.badRequest().body(Map.of("error", "Không tìm thấy."));
        }
        return ResponseEntity.ok(Map.of("nameColor",name));
    }
}
