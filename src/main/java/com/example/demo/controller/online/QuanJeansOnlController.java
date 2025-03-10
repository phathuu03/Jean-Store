package com.example.demo.controller.online;

import com.example.demo.repository.QuanJeansRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class QuanJeansOnlController {
    @Autowired
    private QuanJeansRepository quanJeansRepository;

    @GetMapping("/getNameProduct")
    @ResponseBody
    public ResponseEntity<?> getNameProduct(@RequestParam("idProduct") Long idProduct){
        String name = quanJeansRepository.getNameProduct(idProduct);
        if (name==null){
            return ResponseEntity.badRequest().body(Map.of("error","Không tìm thấy tên"));
        }
        return ResponseEntity.ok(Map.of("nameProduct",name));
    }
}
