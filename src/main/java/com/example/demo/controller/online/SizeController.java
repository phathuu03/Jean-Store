package com.example.demo.controller.online;

import com.example.demo.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class SizeController {
    @Autowired
    private SizeRepository sizeRepository;

    @GetMapping("/getNameSize")
    @ResponseBody
    public ResponseEntity<?> getNameSize(@RequestParam("idSize") Long idSize){
        String name = sizeRepository.getNameSize(idSize);
        if (name==null){
            return ResponseEntity.badRequest().body(Map.of("error","Không tìm thấy tên"));
        }
        return ResponseEntity.ok(Map.of("nameSize",name));
    }
}
